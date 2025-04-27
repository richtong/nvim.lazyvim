return {
	"CopilotC-Nvim/CopilotChat.nvim",
	opts = function()
		return {
			model = "gemma3:27b",
			providers = {
				ollama = {
					prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
					prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,
					get_models = function(headers)
						local response, err =
							require("CopilotChat.utils").curl_get("http://localhost:11434/v1/models", {
								headers = headers,
								json_response = true,
							})

						if err then
							error(err)
						end
						return vim.tbl_map(function(model)
							return {
								id = model.id,
								name = model.id,
							}
						end, response.body.data)
					end,
					embed = function(inputs, headers)
						local response, err =
							require("CopilotChat.utils").curl_post("http://localhost:11434/v1/embeddings", {
								headers = headers,
								json_request = true,
								json_response = true,
								body = {
									input = inputs,
									model = "all-minilm",
								},
							})
						if err then
							error(err)
						end
						return response.body.data
					end,
					get_url = function()
						return "http://localhost:11434/v1/chat/completions"
					end,
				},

				-- requires OPENROUTER_API_KEY env var
				openrouter = {
					prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
					prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,
					get_headers = function()
						local api_key = assert(os.getenv("OPENROUTER_API_KEY"), "OPENROUTER_API_KEY env not set")
						return {
							Authorization = "Bearer " .. api_key,
							["Content-Type"] = "application/json",
						}
					end,
					get_models = function(headers)
						local response, err =
							require("CopilotChat.utils").curl_get("https://openrouter.ai/api/v1/models", {
								headers = headers,
								json_response = true,
							})

						if err then
							error(err)
						end
						return vim.iter(response.body.data)
							:map(function(model)
								return {
									id = model.id,
									name = model.name,
								}
							end)
							:totable()
					end,
					get_url = function()
						return "https://openrouter.ai/api/v1/chat/completions"
					end,
				},

				-- requires MISTRAL_API_KEY env var
				mistral = {
					prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
					prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,
					get_headers = function()
						local api_key = assert(os.getenv("MISTRAL_API_KEY"), "MISTRAL_API_KEY env not set")
						return {
							Authorization = "Bearer " .. api_key,
							["Content-Type"] = "application/json",
						}
					end,
					get_models = function(headers)
						local response, err =
							require("CopilotChat.utils").curl_get("https://api.mistral.ai/v1/models", {
								headers = headers,
								json_response = true,
							})
						if err then
							error(err)
						end

						return vim.iter(response.body.data)
							:filter(function(model)
								return model.capabilities.completion_chat
							end)
							:map(function(model)
								return {
									id = model.id,
									name = model.name,
								}
							end)
							:totable()
					end,
					embed = function(inputs, headers)
						local response, err =
							require("CopilotChat.utils").curl_post("https://api.mistral.ai/v1/embeddings", {
								headers = headers,
								json_request = true,
								json_response = true,
								body = {
									model = "mistral-embed",
									input = inputs,
								},
							})

						if err then
							error(err)
						end
						return response.body.data
					end,
					get_url = function()
						return "https://api.mistral.ai/v1/chat/completions"
					end,
				},
			},
		}
	end,
}
