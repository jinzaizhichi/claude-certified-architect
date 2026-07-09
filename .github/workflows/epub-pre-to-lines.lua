-- ponytail: replaces <pre> blocks with inline <code> lines + &nbsp; indentation
-- avoids white-space:pre UA stylesheet cost on Kobo e-readers
function CodeBlock(el)
  local text = el.text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
  local parts = {}
  for line in (text .. "\n"):gmatch("([^\n]*)\n") do
    local spaces, rest = line:match("^( *)(.*)")
    parts[#parts+1] = "<code>" .. spaces:gsub(" ", "&#160;") .. rest .. "</code>"
  end
  return pandoc.RawBlock("html", "<p>" .. table.concat(parts, "<br/>") .. "</p>")
end
