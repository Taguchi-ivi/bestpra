class Sanitize
    module Config
        CUSTOM = freeze_config(
            :elements => %w[
                    strong em u p h1 h2 h3 h4 h5 ul ol li a blockquote br
            ],
            :protocols => {
                'a' => {'href' => ['http', 'https', 'mailto', :relative]}
            },
        )
    end
end