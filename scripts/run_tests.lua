require("mini.test").setup()

require("mini.test").run({
    execute = {
        reporter = require("mini.test").gen_reporter.stdout({ group_depth = 2 }),
    },
})
