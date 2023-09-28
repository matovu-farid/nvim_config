local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key


ls.add_snippets("all", {
	s("terno", {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
	}),

})
ls.add_snippets("cpp", {

	s("cp", {
		t({
			"#ifndef ONLINE_JUDGE",
			'#include "store/print.h"',
			"#endif",
			"",
			"#include <iostream>",
			"#include <vector>",
			"using ll = long long;",
			"",
			"using namespace std;",
			"",
			"void solve() {"
		}),
		i(1, "code"),
		t({
			"}",
			"",
			"int main() {",
			"#ifndef ONLINE_JUDGE",
			'  freopen("input.txt", "r", stdin);',
			"#endif",
			"  ios::sync_with_stdio(0);",
			"  cin.tie(0);",
			"",
			"  int tests;",
			"  cin >> tests;",
			"  while (tests--) {",
			"    solve();",
			"  }",
			"",
			"  return 0;",
			"}"
		})
	}),

	s("cp2", {
		t({
			"#ifndef ONLINE_JUDGE",
			'#include "store/print.h"',
			"#endif",
			"",
			"#include <iostream>",
			"#include <vector>",
			"using ll = long long;",
			"",
			"using namespace std;",
			"",
			"void solve() {"
		}),
		i(1, "code"),
		t({
			"}",
			"",
			"int main() {",
			"#ifndef ONLINE_JUDGE",
			'  freopen("input.txt", "r", stdin);',
			"#endif",
			"  ios::sync_with_stdio(0);",
			"  cin.tie(0);",
			"  solve();",
			"",
			"  return 0;",
			"}"
		})
	}),

	s("fenwick_temp", {
		t({
			"template<typename T>",
			"struct fenwick {",
			"  vector<T> tree;",
			"  T n;",
			"  fenwick(T n) {",
			"    this->n = n + 1;",
			"    tree.resize(this->n, 0);",
			"  }",
			"  fenwick(T n, vector<T>& v) {",
			"    this->n = n + 1;",
			"    tree.resize(this->n, 0);",
			"    for (T i = 1; i < this->n; i++)",
			"      update(i, v[i - 1]);",
			"  }",
			"  void update(T idx, T val){",
			"    while (idx < n){",
			"      tree[idx] += val;",
			"      idx += (idx & -idx);",
			"    }",
			"  }",
			"  T query(T idx){",
			"    T res = 0;",
			"    while (idx > 0 ){",
			"      res += tree[idx];",
			"      idx -= (idx & -idx);",
			"    }",
			"     return res;",
			"  }",
			"  T query_range(T l, T r) { return query(r) - query(l - 1); }",
			"};",
		})
	})

})
-- vector<int> fenwick;
-- vector<int> nums;
-- void update(int i, int val, int n) {
--   while (i < n + 1) {
--     fenwick[i] += val;
--     i += i & -i;
--   }
-- }
-- void initFenwick(int n) {
--   for (int i = 1; i < n + 1; i++)
--     update(i, nums[i - 1], n + 1);
-- }
-- int query(int idx) {
--   int res = 0;
--   while (idx) {
--     res += fenwick[idx];
--     idx -= idx & -idx;
--   }
--   return res;
-- }
-- int query_range(int l, int r) { return query(r) - query(l - 1); }
