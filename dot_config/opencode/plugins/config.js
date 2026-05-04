// Plugin for automatically configuring things for me
export const ConfigPlugin = async ({ project, client, $, directory, worktree }) => {
  return {
    config: async (config) => {
      const discovered_providers = []
      config.provider = {}
      if (process.env.OPENAI_BASE_URL) {
        const providerName = URL.parse(process.env.OPENAI_BASE_URL).hostname.split(".")[0]
        const response = await fetch(`${process.env.OPENAI_BASE_URL}/models`)
        if (response.ok) {
          discovered_providers.push(providerName)
          const result = await response.json()
          const models = Object.fromEntries(result.data.filter(model => {
            // filter out non-LLM models in lemonade server
            if (model.recipe && model.recipe != "llamacpp") {
              return false
            }
            // filter out wildcard models - seen in litellm auto-discovery
            if (model.id.endsWith("*")) {
              return false
            }
            return true
          }).map(model => {
            const model_config = {
              name: model.id,
              reasoning: true
            }
            if (model.id.indexOf("Qwen3.") != -1 ) {
              model_config["variants"] = {
                "thinking_general": {
                  "chat_template_kwargs": {
                    "enable_thinking": true
                  },
                  "temperature": 1.0
                },
                "thinking_coding": {
                  "chat_template_kwargs": {
                    "enable_thinking": true
                  },
                  "temperature": 0.6
                },
                "nonthinking_general": {
                  "chat_template_kwargs": {
                    "enable_thinking": false
                  },
                  "temperature": 0.7
                },
                "nonthinking_reasoning": {
                  "chat_template_kwargs": {
                    "enable_thinking": false
                  },
                  "temperature": 1.0
                }
              }
            }
            return [
              model.id,
              model_config
            ]
          }))
          config.provider[providerName] = {
            npm: "@ai-sdk/openai-compatible",
            name: providerName,
            options: {
              baseURL: process.env.OPENAI_BASE_URL,
            },
            models: models
          }
        }
      }
      if (discovered_providers.length > 0) {
        config.enabled_providers = discovered_providers
      }
    }
  }
}
