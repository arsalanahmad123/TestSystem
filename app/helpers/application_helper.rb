module ApplicationHelper

    def flash_message(type)
        puts "Flash Type: #{type.inspect}"
        case type
        when :success 
            "alert-success"
        when :info   
            "alert-info"
        when :error 
            "alert-error"
        else
            "alert-warning"
        end
    end

end
