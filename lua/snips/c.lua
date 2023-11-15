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




ls.add_snippets("cpp", {


	s("cp",
		fmt([[
#ifndef online_judge
#include "store/print.h"
#endif

#include <iostream>
#include <vector>
using ll = long long;

using namespace std;
void solve() {{
{}
}}
int main() {{
#ifndef ONLINE_JUDGE
  freopen("input.txt", "r", stdin);
#endif
  ios::sync_with_stdio(0);
  cin.tie(0);
  {}



  return 0;
}}
			]], { i(1, "code"), c(2, {
			t("solve();"),
			t({
				"int tests;",
				"cin >> tests;",
				'while (tests--) {',
				'  solve();',
				'}'
			})

		}) })
	),

	s("fenwick_tree", {
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
	}),
	s("graph", fmt([[
class Graph {{
  {} V;
  list<{}> *l;

public:
  Graph({} v) {{
    V = v;
    l = new list<{}>[V];
  }}
  void addEdge({} i, {} j, bool undir=true) {{
    l[i].push_back(j);
    if(undir) {{
      l[j].push_back(i);
    }}
  }}
  void printAdjList() {{
    for (auto i = 0; i < V; i++) {{
      cout << i << "-->";
      for (auto node : l[i]) {{
        cout << node << ", ";
      }}
      cout << endl;
    }}
  }}
}};

	]], { i(1, "int"), rep(1), rep(1), rep(1), rep(1), rep(1) })),
	s("point", t({
		'struct Point {',
		'  int x;',
		'  int y;',
		'  friend ostream &operator<<(ostream &os, const Point &p) {',
		'    os << "(" << p.x << ", " << p.y << ")";',
		'    return os;',
		'  }',
		'  bool operator<(Point p) {',
		'    if (x == p.x)',
		'      return y < p.y;',
		'    return x < p.x;',
		'  }',
		'};',

	})),
	s("convex_hull", fmt([[

		int angle(Point a, Point b, Point c) {{
		  return a.x * (c.y - b.y) + b.x * (a.y - c.y) + c.x * (b.y - a.y);
		}}
		bool clockwise(Point a, Point b, Point c) {{ return angle(a, b, c) > 0; }}
		bool anti_clockwise(Point a, Point b, Point c) {{ return angle(a, b, c) < 0; }}
		
		vector<Point> convex_hull(vector<Point> &points) {{
		  int n = points.size();
		
		  sort(points.begin(), points.end());
		  Point first = points[0], last = points.back();
		  vector<Point> up, down;
		  up.push_back(first);
		  down.push_back(first);
		  for (int i = 1; i < n; i++) {{
		    if (i == n - 1 || clockwise(first, points[i], last)) {{
		      while (up.size() >= 2 &&
		             !clockwise(up[up.size() - 2], up[up.size() - 1], points[i])) {{
		        up.pop_back();
		      }}
		      up.push_back(points[i]);
		    }}
		    if (i == n - 1 || anti_clockwise(first, points[i], last)) {{
		      while (down.size() >= 2 &&
		             !anti_clockwise(down[down.size() - 2], down[down.size() - 1],
		                             points[i])) {{
		        down.pop_back();
		      }}
		      down.push_back(points[i]);
		    }}
		  }}
		  vector<Point> res(up.begin(), up.end());
		  for (int i = 1; i < down.size() - 1; i++) {{
		    res.push_back(down[i]);
		  }}
		  return res;
		}}

	]],{})),

})
