async function configureLocalInference(config) {
  const servers = [
    { name: "ollama", baseURL: "http://localhost:11434/v1" },
    { name: "lm-studio", baseURL: "http://localhost:1234/v1" },
    { name: "llama-cpp", baseURL: "http://localhost:8080/v1" },
    { name: "lemonade", baseURL: "http://localhost:8000/v1" },
    { name: "lemonade", baseURL: "http://localhost:13305/v1" },
  ];

  for (const server of servers) {
    try {
      const response = await fetch(`${server.baseURL}/models`, {
        signal: AbortSignal.timeout(2000),
      });
      if (!response.ok) continue;

      const result = await response.json();
      if (!result.data?.length) continue;

      const models = Object.fromEntries(
        result.data.map((model) => [
          model.id,
          enrichVariants({ name: model.id }),
        ]),
      );
      config.provider[server.name] = {
        npm: "@ai-sdk/openai-compatible",
        name: server.name,
        options: {
          baseURL: server.baseURL,
          timeout: false,
        },
        models: models,
      };
    } catch {
      // Server not running on this port, skip.
    }
  }
}

function enrichVariants(modelConfig) {
  if (modelConfig.name.indexOf("Qwen3.") != -1) {
    // Default variant
    modelConfig.options = {
      chat_template_kwargs: {
        enable_thinking: true,
      },
      temperature: 1.0,
    };
    modelConfig.limit = {
      context: 262144,
      output: 65536,
    };
    modelConfig["variants"] = {
      Coding: {
        chat_template_kwargs: {
          enable_thinking: true,
        },
        temperature: 0.6,
      },
      "Non-Thinking": {
        chat_template_kwargs: {
          enable_thinking: false,
        },
        temperature: 0.7,
      },
      "Non-Thinking (Reasoning)": {
        chat_template_kwargs: {
          enable_thinking: false,
        },
        temperature: 1.0,
      },
    };
  }
  return modelConfig;
}

async function configureOpenAiBaseUrl(config) {
  if (!process.env.OPENAI_BASE_URL) return;

  const providerName = URL.parse(process.env.OPENAI_BASE_URL).hostname.split(
    ".",
  )[0];
  const response = await fetch(`${process.env.OPENAI_BASE_URL}/models`);
  if (!response.ok) return;

  const result = await response.json();
  const models = Object.fromEntries(
    result.data
      .filter((model) => {
        if (model.recipe && model.recipe != "llamacpp") {
          return false;
        }
        if (model.id.endsWith("*")) {
          return false;
        }
        return true;
      })
      .map((model) => {
        const model_config = {
          name: model.id,
          reasoning: true,
        };
        enrichVariants(model_config);
        return [model.id, model_config];
      }),
  );
  config.provider[providerName] = {
    npm: "@ai-sdk/openai-compatible",
    name: providerName,
    options: {
      baseURL: process.env.OPENAI_BASE_URL,
    },
    models: models,
  };
}

async function configureVertexAnthropic(config) {
  if (process.env.ANTHROPIC_VERTEX_PROJECT_ID) {
    config.provider["google-vertex-anthropic"] = {
      options: {
        project: process.env.ANTHROPIC_VERTEX_PROJECT_ID,
      },
    };
  }
}

async function configureAwsBedrock(config) {
  if (
    typeof process.env.AWS_ACCESS_KEY_ID === "undefined" &&
    typeof process.env.AWS_PROFILE === "undefined"
  ) {
    if (typeof config.disabled_providers === "undefined") {
      config.disabled_providers = [];
    }
    config.disabled_providers.push("amazon-bedrock");
  }
}

export const ConfigPlugin = async ({
  project,
  client,
  $,
  directory,
  worktree,
}) => {
  return {
    config: async (config) => {
      config.provider = {};
      await configureLocalInference(config);
      await configureOpenAiBaseUrl(config);
      await configureVertexAnthropic(config);
      await configureAwsBedrock(config);
    },
  };
};
