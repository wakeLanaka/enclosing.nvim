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
    local v = utils.enclosing_mapping("}")
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
    local entries = {"{", "("}
    local line = ""
    local new_line = utils.append_enclosings(line, entries)

    assert.are.same(line .. ")}", new_line)
  end)
  it("should append \")", function ()
    local entries = {"(", "\""}
    local line = ""
    local new_line = utils.append_enclosings(line, entries)

    assert.are.same(line .. "\")", new_line)
  end)
end)

describe("create_used_enclosing_array", function ()
  it("should return table with entry {( for {println(", function ()
    local line = "{println("
    local enclosings = utils.create_used_enclosing_array(line)
    assert.are.same({"{", "("}, enclosings)
  end)
  it("should return table with entry { for {println()", function ()
    local line = "{println()"
    local enclosings = utils.create_used_enclosing_array(line)
    assert.are.same({"{"}, enclosings)
  end)
  it("should return table with entry { for {\"println(\"", function ()
    local line = "{\"println(\""
    local enclosings = utils.create_used_enclosing_array(line)
    assert.are.same({"{"}, enclosings)
  end)
end)
