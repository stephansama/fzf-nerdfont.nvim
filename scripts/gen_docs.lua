require("mini.doc").generate(nil, nil, {
    annotation_extractor = function(l)
        return l:find("^%-%-%-(%S*) ?")
    end,

    hooks = require("mini.doc").default_hooks,
})
