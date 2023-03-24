local utils = require("enclosing.utils")

describe("contains_value", function ()
  it("should return true if value exists", function ()
    local m = {"a", "b"}
    assert.are.same(true, utils.contains_value(m, "a"))
  end)
  it("should return false if value does not exists", function ()
    local m = {"a", "b"}
    assert.are.same(false, utils.contains_value(m, "c"))
  end)
end)

describe("enclosing_mapping", function ()
  it("should return } on { and vice versa", function ()
    assert.are.same("}", utils.enclosing_mapping("{"))
    assert.are.same("{", utils.enclosing_mapping("}"))
  end)
  it("should return ] on [ and vice versa", function ()
    assert.are.same("]", utils.enclosing_mapping("["))
    assert.are.same("[", utils.enclosing_mapping("]"))
  end)
  it("should return ) on ( and vice versa", function ()
    assert.are.same(")", utils.enclosing_mapping("("))
    assert.are.same("(", utils.enclosing_mapping(")"))
  end)
  it("should return \" on \"", function ()
    assert.are.same("\"", utils.enclosing_mapping("\""))
  end)
end)

describe("append_enclosings", function ()
  it("should append )}", function ()
    local entries = {{"{", 1}, {"(", 2}}
    local line = "  "
    local new_line = utils.append_enclosings(line, entries, 2)

    assert.are.same(line .. ")}", new_line)
  end)
  it("should append \")", function ()
    local entries = {{"(", 1}, {"\"", 2}}
    local line = "  "
    local new_line = utils.append_enclosings(line, entries, 2)

    assert.are.same(line .. "\")", new_line)
  end)
  it("should only append enclosings before cursor", function ()
    local entries = {{"(", 1}, {"{", 2}}
    local cursor_col = 1
    local line = "  "
    local new_line = utils.append_enclosings(line, entries, cursor_col)

    assert.are.same(line:sub(cursor_col,1) .. ")" .. line:sub(cursor_col + 1), new_line)
  end)
  it("should only append enclosings before cursor with \"", function ()
    local entries = {{"\"", 1}, {"{", 2}}
    local cursor_col = 1
    local line = "  "
    local new_line = utils.append_enclosings(line, entries, cursor_col)

    assert.are.same(line:sub(cursor_col,1) .. "\"" .. line:sub(cursor_col + 1), new_line)
  end)
end)

describe("get_used_enclosings", function ()
  it("should return table with entry {( for {println(", function ()
    local line = "{println("
    local enclosings = utils.get_used_enclosings(line)
    assert.are.same({{"{", 1}, {"(", 9}}, enclosings)
  end)
  it("should return table with entry { for {println()", function ()
    local line = "{println()"
    local enclosings = utils.get_used_enclosings(line)
    assert.are.same({{"{", 1}}, enclosings)
  end)
  it("should return table with entry { ( for {\"println(\"", function ()
    local line = "{\"println(\""
    local enclosings = utils.get_used_enclosings(line)
    assert.are.same({{"{", 1}, {"(", 10}}, enclosings)
  end)
end)
