require("mini.test").setup()

require("mini.test").run({
    execute = { reporter = MiniTest.gen_reporter.stdout({ group_depth = 2 }) },
})
