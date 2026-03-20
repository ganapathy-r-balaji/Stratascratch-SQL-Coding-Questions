import streamlit as st
import json
import re
import os

# ─── Page config ───────────────────────────────────────────────────────────────
st.set_page_config(
    page_title="SQL Interview Questions · Ganapathy Raaman Balaji",
    page_icon="🗄️",
    layout="wide",
    initial_sidebar_state="expanded",
)

# ─── Global CSS ────────────────────────────────────────────────────────────────
st.markdown("""
<style>
/* ── Base ─────────────────────────────────────── */
[data-testid="stAppViewContainer"]{background:#0d1117;}
[data-testid="stSidebar"]{background:#161b22;border-right:1px solid #30363d;}
[data-testid="stSidebar"] *{color:#c9d1d9 !important;}
h1,h2,h3,h4,h5,h6{color:#e6edf3;}
p,li,label,span{color:#c9d1d9;}

/* ── Header ribbon ───────────────────────────── */
.hdr{
  background:#161b22;
  border-bottom:1px solid #30363d;
  padding:10px 20px 10px 18px;
  display:flex;
  align-items:center;
  gap:14px;
  margin-bottom:20px;
  border-radius:8px;
}
.hdr-icon{font-size:28px;line-height:1;}
.hdr-title{
  font-size:20px;font-weight:700;
  color:#e6edf3;letter-spacing:.3px;
}
.hdr-sub{font-size:13px;color:#8b949e;margin-top:2px;}
.hdr-author{
  margin-left:auto;font-size:12px;
  color:#8b949e;text-align:right;
}
.hdr-author strong{color:#c9d1d9;}

/* ── Badge pills ─────────────────────────────── */
.badge{
  display:inline-block;
  padding:2px 10px;border-radius:999px;
  font-size:12px;font-weight:600;letter-spacing:.4px;
}
.badge-easy{background:#1a4731;color:#3fb950;}
.badge-medium{background:#472914;color:#f0883e;}
.badge-hard{background:#4a1010;color:#ff7b72;}
.badge-unknown{background:#21262d;color:#8b949e;}
.badge-company{background:#1a2744;color:#79c0ff;}

/* ── Problem card ────────────────────────────── */
.prob-card{
  background:#161b22;
  border:1px solid #30363d;
  border-radius:10px;
  padding:20px 24px;
  margin-bottom:16px;
}
.prob-title{
  font-size:22px;font-weight:700;
  color:#e6edf3;margin-bottom:8px;
}
.prob-meta{
  display:flex;flex-wrap:wrap;gap:8px;
  margin-bottom:14px;
}
.prob-label{
  font-size:12px;font-weight:600;
  color:#8b949e;text-transform:uppercase;
  letter-spacing:.6px;margin-top:14px;margin-bottom:4px;
}
.prob-stmt{
  font-size:14px;color:#c9d1d9;
  line-height:1.7;
  background:#0d1117;border:1px solid #30363d;
  border-radius:6px;padding:12px 16px;
}

/* ── SQL block ───────────────────────────────── */
.sql-wrapper{
  background:#0d1117;
  border:1px solid #30363d;
  border-radius:8px;
  padding:16px;
  font-family:'JetBrains Mono','Fira Code',monospace;
  font-size:13px;
  line-height:1.65;
  overflow-x:auto;
  color:#c9d1d9;
  white-space:pre;
}
/* SQL keyword highlighting */
.kw{color:#ff7b72;}
.fn{color:#d2a8ff;}
.str{color:#a5d6ff;}
.cm{color:#8b949e;font-style:italic;}
.num{color:#79c0ff;}

/* ── Tables section ──────────────────────────── */
.table-info{
  background:#0d1117;border:1px solid #30363d;
  border-radius:6px;padding:12px 16px;
  font-size:13px;color:#c9d1d9;
  font-family:monospace;line-height:1.7;
  white-space:pre-wrap;
}

/* ── Stats bar ───────────────────────────────── */
.stat-bar{
  background:#161b22;border:1px solid #30363d;
  border-radius:8px;padding:12px 18px;
  margin-bottom:16px;
  display:flex;flex-wrap:wrap;gap:24px;align-items:center;
}
.stat-item{text-align:center;}
.stat-val{font-size:24px;font-weight:700;color:#e6edf3;}
.stat-lbl{font-size:11px;color:#8b949e;text-transform:uppercase;letter-spacing:.5px;}

/* ── Footer ──────────────────────────────────── */
.footer{
  background:#161b22;border-top:1px solid #30363d;
  padding:14px 20px;border-radius:8px;
  display:flex;align-items:center;flex-wrap:wrap;
  gap:16px;margin-top:24px;
}
.footer-name{font-size:14px;font-weight:700;color:#e6edf3;}
.footer-role{font-size:12px;color:#8b949e;}
.footer-links{display:flex;gap:14px;flex-wrap:wrap;}
.footer-link{
  display:flex;align-items:center;gap:6px;
  color:#8b949e;font-size:12px;text-decoration:none;
}
.footer-link:hover{color:#f97316;}

/* ── Selectbox & inputs ──────────────────────── */
[data-testid="stSelectbox"] label{color:#8b949e !important;font-size:12px !important;}
div[data-baseweb="select"] > div{
  background:#21262d !important;border-color:#30363d !important;color:#e6edf3 !important;
}
</style>
""", unsafe_allow_html=True)

# ─── Load data ─────────────────────────────────────────────────────────────────
@st.cache_data
def load_data():
    data_path = os.path.join(os.path.dirname(__file__), "data", "sql_problems.json")
    with open(data_path) as f:
        return json.load(f)

problems = load_data()

# ─── SQL Syntax Highlighter ────────────────────────────────────────────────────
def highlight_sql(sql: str) -> str:
    """Simple SQL syntax highlighter returning HTML."""
    keywords = r'\b(SELECT|FROM|WHERE|JOIN|LEFT|RIGHT|INNER|OUTER|FULL|CROSS|ON|GROUP\s+BY|ORDER\s+BY|HAVING|WITH|AS|UNION|ALL|DISTINCT|CASE|WHEN|THEN|ELSE|END|AND|OR|NOT|IN|IS|NULL|LIKE|BETWEEN|EXISTS|INSERT|UPDATE|DELETE|CREATE|TABLE|INDEX|VIEW|DROP|ALTER|SET|INTO|VALUES|LIMIT|OFFSET|PARTITION\s+BY|OVER|ROWS|RANGE|UNBOUNDED|PRECEDING|FOLLOWING|CURRENT\s+ROW)\b'
    functions = r'\b(COUNT|SUM|AVG|MAX|MIN|COALESCE|NULLIF|CAST|CONVERT|DATE|EXTRACT|TO_CHAR|TO_DATE|ROUND|FLOOR|CEIL|CEILING|ABS|RANK|ROW_NUMBER|DENSE_RANK|LAG|LEAD|FIRST_VALUE|LAST_VALUE|NTH_VALUE|NTILE|PERCENT_RANK|CUME_DIST|CONCAT|UPPER|LOWER|TRIM|LTRIM|RTRIM|SUBSTRING|REPLACE|LENGTH|CHAR_LENGTH|SPLIT_PART|REGEXP_REPLACE|STRPOS|ARRAY_AGG|STRING_AGG|LISTAGG|GROUP_CONCAT|IIF|IFF)\b'

    import html as htmllib
    escaped = htmllib.escape(sql)

    # Comments
    escaped = re.sub(r'(--[^\n]*)', r'<span class="cm">\1</span>', escaped)
    # Strings
    escaped = re.sub(r"(&#x27;[^&#x27;]*&#x27;|'[^']*')", r'<span class="str">\1</span>', escaped)
    # Keywords
    escaped = re.sub(keywords, r'<span class="kw">\1</span>', escaped, flags=re.IGNORECASE)
    # Functions
    escaped = re.sub(functions, r'<span class="fn">\1</span>', escaped, flags=re.IGNORECASE)
    # Numbers
    escaped = re.sub(r'\b(\d+(?:\.\d+)?)\b', r'<span class="num">\1</span>', escaped)

    return escaped

# ─── Header ribbon ─────────────────────────────────────────────────────────────
st.markdown("""
<div class="hdr">
  <span class="hdr-icon">🗄️</span>
  <div>
    <div class="hdr-title">SQL Interview Questions</div>
    <div class="hdr-sub">StrataScratch · PostgreSQL Solutions</div>
  </div>
  <div class="hdr-author">
    Built by <strong>Ganapathy Raaman Balaji</strong>
  </div>
</div>
""", unsafe_allow_html=True)

# ─── Sidebar filters ───────────────────────────────────────────────────────────
with st.sidebar:
    st.markdown("### 🔍 Filter Questions")
    st.markdown("---")

    all_diffs = ['All', 'Easy', 'Medium', 'Hard', 'Unknown']
    diff_sel = st.selectbox("Difficulty", all_diffs, index=0)

    search_q = st.text_input("🔎 Search title / keyword", placeholder="e.g. churn, rank, join…")

    companies = sorted(set(p['company'] for p in problems if p.get('company')))
    company_sel = st.selectbox("Company", ['All'] + companies, index=0)

    st.markdown("---")
    st.markdown("**📊 Stats**")
    total = len(problems)
    easy = sum(1 for p in problems if p['difficulty'] == 'Easy')
    med = sum(1 for p in problems if p['difficulty'] == 'Medium')
    hard = sum(1 for p in problems if p['difficulty'] == 'Hard')

    st.markdown(f"""
    <div style="font-size:13px;line-height:2.2;">
      Total&nbsp;&nbsp;&nbsp;&nbsp;<strong style="color:#e6edf3;">{total}</strong><br>
      <span style="color:#3fb950;">Easy</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style="color:#e6edf3;">{easy}</strong><br>
      <span style="color:#f0883e;">Medium</span>&nbsp;&nbsp;<strong style="color:#e6edf3;">{med}</strong><br>
      <span style="color:#ff7b72;">Hard</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style="color:#e6edf3;">{hard}</strong>
    </div>
    """, unsafe_allow_html=True)

    st.markdown("---")
    st.markdown(
        '<div style="font-size:11px;color:#8b949e;line-height:1.6;">'
        '🔗 <a href="https://www.linkedin.com/in/ganapathybalaji/" style="color:#f97316;" target="_blank">LinkedIn</a>'
        '&nbsp;·&nbsp;'
        '<a href="https://github.com/ganapathy-r-balaji/Stratascratch-SQL-Coding-Questions" style="color:#f97316;" target="_blank">GitHub Repo</a>'
        '</div>',
        unsafe_allow_html=True
    )

# ─── Filter problems ───────────────────────────────────────────────────────────
filtered = problems
if diff_sel != 'All':
    filtered = [p for p in filtered if p['difficulty'] == diff_sel]
if company_sel != 'All':
    filtered = [p for p in filtered if p.get('company') == company_sel]
if search_q and search_q.strip():
    sq = search_q.strip().lower()
    filtered = [
        p for p in filtered
        if sq in p.get('title', '').lower()
        or sq in p.get('problem_statement', '').lower()
        or sq in p.get('id', '')
    ]

if not filtered:
    st.warning("No questions match your filters. Try adjusting the difficulty or company.")
    st.stop()

# ─── Question selector ─────────────────────────────────────────────────────────
def make_label(p):
    diff_icon = {'Easy': '🟢', 'Medium': '🟡', 'Hard': '🔴'}.get(p['difficulty'], '⚪')
    return f"{diff_icon}  ID {p['id']} · {p['title']}"

labels = [make_label(p) for p in filtered]
# Check if there's a navigation-triggered label
default_label = st.session_state.pop('nav_label', labels[0])
default_idx = labels.index(default_label) if default_label in labels else 0
selected_label = st.selectbox("**Select a question**", labels, index=default_idx)
selected_idx = labels.index(selected_label)
prob = filtered[selected_idx]

# ─── Difficulty badge ─────────────────────────────────────────────────────────
diff_class = {
    'Easy': 'badge-easy',
    'Medium': 'badge-medium',
    'Hard': 'badge-hard',
}.get(prob['difficulty'], 'badge-unknown')

company_badge = f'<span class="badge badge-company">{prob["company"]}</span>' if prob.get('company') else ''
diff_badge = f'<span class="badge {diff_class}">{prob["difficulty"]}</span>'
id_badge = f'<span class="badge badge-unknown">ID {prob["id"]}</span>'

# ─── Main problem display ──────────────────────────────────────────────────────
col1, col2 = st.columns([3, 1])

with col1:
    st.markdown(f"""
    <div class="prob-card">
      <div class="prob-title">{prob["title"]}</div>
      <div class="prob-meta">
        {id_badge}
        {diff_badge}
        {company_badge}
      </div>
    """, unsafe_allow_html=True)

    if prob.get('problem_statement'):
        st.markdown('<div class="prob-label">Problem Statement</div>', unsafe_allow_html=True)
        st.markdown(f'<div class="prob-stmt">{prob["problem_statement"]}</div>', unsafe_allow_html=True)

    st.markdown("</div>", unsafe_allow_html=True)

    # Table info
    if prob.get('table_info') and len(prob['table_info'].strip()) > 10:
        with st.expander("📋 Tables & Data Dictionary", expanded=False):
            st.markdown(f'<div class="table-info">{prob["table_info"]}</div>', unsafe_allow_html=True)

    # SQL Solution
    st.markdown('<div class="prob-label" style="font-size:13px;font-weight:700;color:#8b949e;margin-top:6px;">💡 SQL Solution</div>', unsafe_allow_html=True)
    sql_code = prob.get('sql', '').strip()

    if sql_code:
        highlighted = highlight_sql(sql_code)
        st.markdown(
            f'<div class="sql-wrapper">{highlighted}</div>',
            unsafe_allow_html=True
        )
        # Copy-friendly raw text in expander
        with st.expander("📋 Copy SQL (plain text)", expanded=False):
            st.code(sql_code, language='sql')
    else:
        st.info("No SQL solution extracted from this file.")

with col2:
    st.markdown("#### 📌 Quick Info")
    st.markdown(f"""
    <div style="background:#161b22;border:1px solid #30363d;border-radius:8px;padding:14px;">
      <div style="font-size:12px;color:#8b949e;margin-bottom:4px;">Problem ID</div>
      <div style="font-size:20px;font-weight:700;color:#e6edf3;margin-bottom:12px;">#{prob["id"]}</div>
      <div style="font-size:12px;color:#8b949e;margin-bottom:4px;">Difficulty</div>
      <div style="margin-bottom:12px;">{diff_badge}</div>
      <div style="font-size:12px;color:#8b949e;margin-bottom:4px;">Company</div>
      <div style="margin-bottom:12px;">{company_badge}</div>
      <div style="font-size:12px;color:#8b949e;margin-bottom:4px;">File</div>
      <div style="font-size:11px;color:#c9d1d9;word-break:break-all;">{prob.get("filename","")}</div>
    </div>
    """, unsafe_allow_html=True)

    st.markdown("<br>", unsafe_allow_html=True)

    # Navigation
    st.markdown("#### ⏭️ Navigate")
    curr_global = problems.index(prob) if prob in problems else 0
    nav_col1, nav_col2 = st.columns(2)
    with nav_col1:
        if st.button("◀ Prev", use_container_width=True):
            new_idx = (selected_idx - 1) % len(filtered)
            st.session_state['nav_label'] = labels[new_idx]
            st.rerun()
    with nav_col2:
        if st.button("Next ▶", use_container_width=True):
            new_idx = (selected_idx + 1) % len(filtered)
            st.session_state['nav_label'] = labels[new_idx]
            st.rerun()

    st.markdown(f"""
    <div style="font-size:11px;color:#8b949e;text-align:center;margin-top:6px;">
      Question {selected_idx + 1} of {len(filtered)}
    </div>
    """, unsafe_allow_html=True)

# ─── Footer ───────────────────────────────────────────────────────────────────
st.markdown("""
<div class="footer">
  <div>
    <span class="footer-name">Ganapathy Raaman Balaji</span>
    <span class="footer-role">&nbsp;·&nbsp;Sr. Data Scientist, Aftermarket Analytics · Caterpillar Inc.</span>
  </div>
  <div class="footer-links">
    <a class="footer-link" href="https://www.linkedin.com/in/ganapathybalaji/" target="_blank">
      <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
        <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
      </svg>
      LinkedIn
    </a>
    <a class="footer-link" href="mailto:bgraaman89@gmail.com">
      <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <rect x="2" y="4" width="20" height="16" rx="2"/><path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"/>
      </svg>
      bgraaman89@gmail.com
    </a>
    <span class="footer-link">
      <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.15 12a19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 3.06 1h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L7.09 8.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 21 16z"/>
      </svg>
      +1 309-424-8222 / +91 638-269-4439
    </span>
  </div>
</div>
""", unsafe_allow_html=True)
