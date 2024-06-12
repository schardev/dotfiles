if (( $+commands[fzf] )); then
	# Creates a gitignore file template
	function add_gitignore_template() {
		local templates=$(curl -s https://api.github.com/gitignore/templates | jq -r '.[]')
		local selected_template=$(echo "$templates" | fzf --prompt="Select a .gitignore template: ")

		if [[ -n "$selected_template" ]]; then
			curl -s "https://api.github.com/gitignore/templates/$selected_template" | jq -r '.source' > .gitignore
			echo "Created gitignore file with $selected_template template"
		fi
	}

	# Creates a license file template
	function add_license_template() {
		local licenses=$(curl -s https://api.github.com/licenses | jq -r '.[].key')
		local selected_license=$(echo "$licenses" | fzf --prompt="Select a license template: ")

		if [[ -n "$selected_license" ]]; then
			curl -s "https://api.github.com/licenses/$selected_license" | jq -r '.body' > LICENSE
			echo "Created $selected_license license template. Edit it accordingly."
		fi
	}
fi
