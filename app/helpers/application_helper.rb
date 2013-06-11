module ApplicationHelper

	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings(:user)
	end

	def verbose_noun(str)
		str = str.downcase
		prefix = "an"
		prefix = "a" unless str =~ /^[aeiou]/
		"#{prefix} #{str}"
	end
end
