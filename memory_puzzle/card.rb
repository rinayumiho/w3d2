class Card
    attr_reader :face_value, :face_up

    def initialize(face_value) #String
        @face_value = face_value
        @face_up = false
    end

    def reveal
        @face_up = true
        puts "The value is #{@face_value}"
        return @face_value
    end

    def hide
        @face_up = false
    end

    def ==(other_card_value) # card instance's value attribute
        @face_value == other_card_value # self.face_value == other_card.face_value

    end

end