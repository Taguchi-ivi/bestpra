class EmailValidator < ActiveModel::EachValidator

    # record    => userオブジェクト
    # attrubute => 属性(email)
    # value     => 値を取得(test@a.a)
    def validate_each(record, attrubute, value)
        # byebug
        # text length
        max = 255
        record.errors.add(attribute, :too_long, count: max) if value.length > max

        # format
        # =~ => 文字列と正規表現が一致するかを検証
        format = /\A\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\z/
        record.errors.add(attribute, :invalid) unless format =~ value

        # uniqueness
        # record.errors.add(attribute, :taken) if record.email_activated?
    end
end