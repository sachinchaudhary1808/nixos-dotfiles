-- lua snippiets

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node

ls.add_snippets("c", {
	-- Main function snippet
	s("main", {
		t({ "#include <stdio.h>", "", "int main() {", "\t" }),
		i(1, "// Your code here"), -- Placeholder for user code
		t({ "", "    return 0;", "}" }), -- Closing main function
	}),

	-- Printf snippet
	s("pr", {
		t('printf("'), -- Start printf statement
		i(1, "Your string here"), -- Placeholder inside the quotes
		t('");'), -- Closing printf statement
	}),
})
