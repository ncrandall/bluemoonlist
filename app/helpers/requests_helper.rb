module RequestsHelper
	def status_text_class(request)
		case request.status

		when :active
			"text-success"
		when :paused
			"text-warning"
		when :cancelled
			"muted"
		when :done
			"text-info"
		else
			""
		end
	end
end
