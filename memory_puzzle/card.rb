class Card
    attr_reader :face_value, :card_state

    def initialize(face_value, card_state) #String, boolean
        @face_value = face_value
        @card_state = card_state
    end

    def face_up
        if @card_state == true
            puts "The value is #{@face_value}" 
            return true
        end
        false
    end


end