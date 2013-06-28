module UsersHelper

	def profile_image(user)
		url = 'no_pic.jpg'
		if !user.image_url.nil?
			url = user.image_url
		end

		image_tag url, height: 50, width: 50
	end

	def large_profile_image(user)
		url = 'no_pic.jpg'
		if !user.image_url.nil?
			tmp = URI::parse(user.image_url)
			tmp.query = "type=large"
			url = tmp.to_s
		end
		image_tag(url)
	end
end
