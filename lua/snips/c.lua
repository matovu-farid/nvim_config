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
  freopen(".input", "r", stdin);
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
  int V;
  vector<vector<int>> l;

public:
  Graph(int v) {{
    V = v;
    l.resize(v);
  }}
  void addEdge(int i, int j, bool undir = true) {{

    l[i].push_back(j);
    if (undir) {{
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


	]], {  })),
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
  s("segmenttree",fmt([[
  struct segmenttree {{
  vector<int> st;
  int n;
  void init(int n) {{
    this->n = n;
    st.resize(4 * n, 0);
  }}

  int query(int l, int r) {{
    return query(0, n - 1,0, l, r);
  }}
  int query(int start, int ending, int node, int l, int r){{
    if (ending < l or r < start) return 0;
    if (start >= l and ending <= r) return st[node];
    int mid = start + (ending - start) / 2;
    return query(start, mid, 2 * node + 1, l, r) + query(mid + 1, ending, 2 * node + 2, l , r);
  }}

  void update(int start, int ending, int node, int idx, int val){{
    if (start == ending) {{
      st[node] = val;
      return;
    }}
    int mid = start + (ending - start) / 2;
    if (idx >= start and idx <= mid){{
      update(start, mid, 2 * node + 1, idx, val);
    }}else {{
      update(mid + 1, ending, 2 * node + 2, idx, val);
    }}
    st[node] = st[2 * node + 1] + st[2 * node + 2];
  }}
  void build(int start, int ending, int node, vector<int> &v) {{
    if (start == ending) {{
      st[node] = v[start];
      return;
    }}
    int mid = start + (ending - start) / 2;
    build(start, mid, 2 * node + 1, v);
    build(mid + 1, ending, 2 * node + 2, v);
    st[node] = st[2 * node + 1] + st[2 * node + 2];
  }}

  void build(vector<int> &v) {{
    build(0, n - 1, 0, v);
  }}
  void update(int idx, int val){{
    update(0, n - 1, 0, idx, val);
  }}
}};

  ]],{})),
  s("segmenttreelazy",fmt([[
struct segmenttree {{
  vector<int> st, lazy;

  int n;
  void init(int n) {{
    this->n = n;
    st.resize(4 * n, 0);
    lazy.resize(4 * n, 0);
  }}

  void flush(int start, int ending, int node) {{
    int lazyVal = lazy[node];
    st[node] += lazyVal * (ending - start + 1);
    lazy[node] = 0;
    if (start == ending)
      return;
    lazy[2 * node + 1] += lazyVal;
    lazy[2 * node + 2] += lazyVal;
  }}
  int query(int start, int ending, int node, int l, int r) {{
    if (ending < l or r < start)
      return 0;
    flush(start, ending, node);
    if (start >= l and ending <= r) {{
      return st[node];
    }}
    int mid = start + (ending - start) / 2;
    return query(start, mid, 2 * node + 1, l, r) +
           query(mid + 1, ending, 2 * node + 2, l, r);
  }}
  void update(int start, int ending, int node, int l, int r, int val) {{
    if (ending < l or r < start)
      return;
    flush(start, ending, node);
    if (start >= l and ending <= r) {{
      lazy[node] += val;
      flush(start, ending, node);
      return;
    }}
    int mid = start + (ending - start) / 2;
    update(start, mid, 2 * node + 1, l, r, val);
    update(mid + 1, ending, 2 * node + 2, l, r, val);
    st[node] = st[2 * node + 1] + st[2 * node + 2];
  }}

  void build(int start, int ending, int node, vector<int> &v) {{
    if (start == ending) {{
      st[node] = v[start];
      return;
    }}
    int mid = start + (ending - start) / 2;
    build(start, mid, 2 * node + 1, v);
    build(mid + 1, ending, 2 * node + 2, v);
    st[node] = st[2 * node + 1] + st[2 * node + 2];
  }}

  int query(int l, int r) {{ return query(0, n - 1, 0, l, r); }}
  void build(vector<int> &v) {{ build(0, n - 1, 0, v); }}
  void update(int l, int r, int val) {{ update(0, n - 1, 0, l, r, val); }}
}};


  ]],{}))

})
