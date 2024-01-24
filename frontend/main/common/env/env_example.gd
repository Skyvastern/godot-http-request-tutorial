# This is an example ENV file, as the ENV file itself is not pushed to GitHub
# To make use of ENV, do the following -
# 1. Duplicate env_example.gd and name the new file to env.gd
# 2. Rename env.gd's class name from ENV_EXAMPLE -> ENV
# 3. In env.gd, fill in the variable values with your API keys

extends Node
class_name ENV_EXAMPLE

static var OPEN_AI_API_KEY: String = ""
