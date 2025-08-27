return {
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node

      -- JavaScript/TypeScript
      ls.add_snippets("javascript", {
        s("cl", { t("console.log("), i(1), t(");") }),
        s("ce", { t("console.error("), i(1), t(");") }),
        s("cw", { t("console.warn("), i(1), t(");") }),
        s("af", { t("const "), i(1, "name"), t(" = ("), i(2), t(") => {"), t({"", "  "}), i(0), t({"", "};"}) }),
        s("fn", { t("function "), i(1, "name"), t("("), i(2), t(") {"), t({"", "  "}), i(0), t({"", "}"}) }),
        s("imp", { t("import "), i(1), t(" from '"), i(2), t("';") }),
        s("impd", { t("import { "), i(1), t(" } from '"), i(2), t("';") }),
        s("exp", { t("export default "), i(1), t(";") }),
        s("expn", { t("export const "), i(1), t(" = "), i(2), t(";") }),
        s("try", { t({"try {", "  "}), i(1), t({"", "} catch ("}), i(2, "error"), t({") {", "  "}), i(3), t({"", "}"}) }),
        s("async", { t("async "), i(1, "function"), t("("), i(2), t(") {"), t({"", "  "}), i(0), t({"", "}"}) }),
        s("await", { t("await "), i(1), t(";") }),
        s("promise", { t("new Promise((resolve, reject) => {"), t({"", "  "}), i(1), t({"", "});"}) }),
        s("timeout", { t("setTimeout(() => {"), t({"", "  "}), i(1), t({"", "}, "}), i(2, "1000"), t(");"}) }),
        s("interval", { t("setInterval(() => {"), t({"", "  "}), i(1), t({"", "}, "}), i(2, "1000"), t(");"}) }),
      })

      -- ls.add_snippets("typescript", {
      --   s("int", { t("interface "), i(1, "Name"), t({" {", "  "}), i(2), t({"", "}"}) }),
      --   s("type", { t("type "), i(1, "Name"), t(" = "), i(2), t(";") }),
      --   s("enum", { t("enum "), i(1, "Name"), t({" {", "  "}), i(2), t({"", "}"}) }),
      --   s("class", { t("class "), i(1, "Name"), t({" {", "  constructor("}), i(2), t({") {", "    "}), i(3), t({"", "  }", "}"}) }),
      --   s("generic", { t("<"), i(1, "T"), t(">") })
      -- })

      -- React
      ls.add_snippets("javascriptreact", {
        s("rfc", { t("const "), i(1, "Component"), t({" = () => {", "  return (", "    <div>", "      "}), i(2), t({"", "    </div>", "  );", "};", "", "export default "}), f(function(args) return args[1][1] end, {1}), t(";") }),
        s("rfce", { t("import React from 'react';"), t({"", "", "const "}), i(1, "Component"), t({" = () => {", "  return (", "    <div>", "      "}), i(2), t({"", "    </div>", "  );", "};", "", "export default "}), f(function(args) return args[1][1] end, {1}), t(";") }),
        s("use", { t("const ["), i(1, "state"), t(", set"), f(function(args) return args[1][1]:gsub("^%l", string.upper) end, {1}), t("] = useState("), i(2), t(");") }),
        s("ue", { t("useEffect(() => {"), t({"", "  "}), i(1), t({"", "}, ["}), i(2), t("]);") }),
        s("uc", { t("const "), i(1, "value"), t(" = useCallback(() => {"), t({"", "  "}), i(2), t({"", "}, ["}), i(3), t("]);") }),
        s("um", { t("const "), i(1, "value"), t(" = useMemo(() => {"), t({"", "  return "}), i(2), t({"", "}, ["}), i(3), t("]);") }),
        s("ur", { t("const "), i(1, "ref"), t(" = useRef("), i(2), t(");") }),
        s("ucon", { t("const "), i(1, "context"), t(" = useContext("), i(2), t(");") }),
        s("comp", { t("<"), i(1, "Component"), t(" "), i(2), t(" />") }),
      })

      ls.add_snippets("typescriptreact", {
        s("rfc", { t("interface "), i(1, "Component"), t("Props {"), t({"", "  "}), i(2), t({"", "}", "", "const "}), f(function(args) return args[1][1] end, {1}), t(": React.FC<"), f(function(args) return args[1][1] end, {1}), t("Props> = ("), i(3), t({") => {", "  return (", "    <div>", "      "}), i(4), t({"", "    </div>", "  );", "};", "", "export default "}), f(function(args) return args[1][1] end, {1}), t(";") }),
      })

      -- Python
      ls.add_snippets("python", {
        s("def", { t("def "), i(1, "function_name"), t("("), i(2), t("):"), t({"", "    "}), i(0) }),
        s("class", { t("class "), i(1, "ClassName"), t(":"), t({"", "    def __init__(self"}), i(2), t("):"), t({"", "        "}), i(0) }),
        s("if", { t("if "), i(1, "condition"), t(":"), t({"", "    "}), i(0) }),
        s("elif", { t("elif "), i(1, "condition"), t(":"), t({"", "    "}), i(0) }),
        s("else", { t({"else:", "    "}), i(0) }),
        s("for", { t("for "), i(1, "item"), t(" in "), i(2, "iterable"), t(":"), t({"", "    "}), i(0) }),
        s("while", { t("while "), i(1, "condition"), t(":"), t({"", "    "}), i(0) }),
        s("try", { t({"try:", "    "}), i(1), t({"", "except "}), i(2, "Exception"), t({" as e:", "    "}), i(3, "pass") }),
        s("with", { t("with "), i(1), t(" as "), i(2), t(":"), t({"", "    "}), i(0) }),
        s("lambda", { t("lambda "), i(1), t(": "), i(2) }),
        s("list", { t("["), i(1), t(" for "), i(2), t(" in "), i(3), t("]") }),
        s("dict", { t("{"), i(1, "key"), t(": "), i(2, "value"), t(" for "), i(3), t(" in "), i(4), t("}") }),
        s("main", { t({"if __name__ == '__main__':", "    "}), i(0) }),
        s("import", { t("import "), i(1) }),
        s("from", { t("from "), i(1), t(" import "), i(2) }),
      })

      -- Java
      ls.add_snippets("java", {
        s("class", { t("public class "), i(1, "ClassName"), t({" {", "    "}), i(0), t({"", "}"}) }),
        s("main", { t({"public static void main(String[] args) {", "    "}), i(0), t({"", "}"}) }),
        s("method", { t("public "), i(1, "void"), t(" "), i(2, "methodName"), t("("), i(3), t(") {"), t({"", "    "}), i(0), t({"", "}"}) }),
        s("sout", { t("System.out.println("), i(1), t(");") }),
        s("for", { t("for (int "), i(1, "i"), t(" = 0; "), f(function(args) return args[1][1] end, {1}), t(" < "), i(2, "length"), t("; "), f(function(args) return args[1][1] end, {1}), t("++) {"), t({"", "    "}), i(0), t({"", "}"}) }),
        s("foreach", { t("for ("), i(1, "Type"), t(" "), i(2, "item"), t(" : "), i(3, "collection"), t(") {"), t({"", "    "}), i(0), t({"", "}"}) }),
        s("if", { t("if ("), i(1, "condition"), t(") {"), t({"", "    "}), i(0), t({"", "}"}) }),
        s("try", { t({"try {", "    "}), i(1), t({"", "} catch ("}), i(2, "Exception"), t(" e) {"), t({"", "    "}), i(3), t({"", "}"}) }),
        s("interface", { t("public interface "), i(1, "InterfaceName"), t({" {", "    "}), i(0), t({"", "}"}) }),
      })

      -- C#
      ls.add_snippets("cs", {
        s("class", { t("public class "), i(1, "ClassName"), t({"", "{", "    "}), i(0), t({"", "}"}) }),
        s("method", { t("public "), i(1, "void"), t(" "), i(2, "MethodName"), t("("), i(3), t(")"), t({"", "{", "    "}), i(0), t({"", "}"}) }),
        s("prop", { t("public "), i(1, "string"), t(" "), i(2, "Property"), t(" { get; set; }") }),
        s("autoprop", { t("public "), i(1, "string"), t(" "), i(2, "Property"), t(" { get; set; } = "), i(3), t(";") }),
        s("cw", { t("Console.WriteLine("), i(1), t(");") }),
        s("cr", { t("Console.ReadLine()") }),
        s("for", { t("for (int "), i(1, "i"), t(" = 0; "), f(function(args) return args[1][1] end, {1}), t(" < "), i(2, "length"), t("; "), f(function(args) return args[1][1] end, {1}), t("++)"), t({"", "{", "    "}), i(0), t({"", "}"}) }),
        s("foreach", { t("foreach ("), i(1, "var"), t(" "), i(2, "item"), t(" in "), i(3, "collection"), t(")"), t({"", "{", "    "}), i(0), t({"", "}"}) }),
        s("if", { t("if ("), i(1, "condition"), t(")"), t({"", "{", "    "}), i(0), t({"", "}"}) }),
        s("try", { t({"try", "{", "    "}), i(1), t({"", "}", "catch ("}), i(2, "Exception"), t(" ex)"), t({"", "{", "    "}), i(3), t({"", "}"}) }),
        s("using", { t("using "), i(1), t(";") }),
        s("namespace", { t("namespace "), i(1), t({"", "{", "    "}), i(0), t({"", "}"}) }),
      })

      -- C++
      ls.add_snippets("cpp", {
        s("include", { t("#include <"), i(1, "iostream"), t(">") }),
        s("main", { t({"int main() {", "    "}), i(0), t({"", "    return 0;", "}"}) }),
        s("class", { t("class "), i(1, "ClassName"), t({" {", "public:", "    "}), i(0), t({"", "};"}) }),
        s("for", { t("for (int "), i(1, "i"), t(" = 0; "), f(function(args) return args[1][1] end, {1}), t(" < "), i(2, "n"), t("; "), f(function(args) return args[1][1] end, {1}), t("++) {"), t({"", "    "}), i(0), t({"", "}"}) }),
        s("cout", { t("std::cout << "), i(1), t(" << std::endl;") }),
        s("cin", { t("std::cin >> "), i(1), t(";") }),
        s("vector", { t("std::vector<"), i(1, "int"), t("> "), i(2, "vec"), t(";") }),
        s("if", { t("if ("), i(1, "condition"), t(") {"), t({"", "    "}), i(0), t({"", "}"}) }),
      })

      -- Go
      ls.add_snippets("go", {
        s("package", { t("package "), i(1, "main") }),
        s("import", { t("import \""), i(1), t("\"") }),
        s("func", { t("func "), i(1, "name"), t("("), i(2), t(") "), i(3, "error"), t({" {", "    "}), i(0), t({"", "}"}) }),
        s("main", { t({"func main() {", "    "}), i(0), t({"", "}"}) }),
        s("if", { t("if "), i(1, "condition"), t({" {", "    "}), i(0), t({"", "}"}) }),
        s("for", { t("for "), i(1, "i := 0; i < 10; i++"), t({" {", "    "}), i(0), t({"", "}"}) }),
        s("struct", { t("type "), i(1, "Name"), t({" struct {", "    "}), i(0), t({"", "}"}) }),
        s("interface", { t("type "), i(1, "Name"), t({" interface {", "    "}), i(0), t({"", "}"}) }),
        s("method", { t("func ("), i(1, "r"), t(" "), i(2, "Receiver"), t(") "), i(3, "Method"), t("("), i(4), t(") "), i(5, "error"), t({" {", "    "}), i(0), t({"", "}"}) }),
        s("err", { t("if err != nil {"), t({"", "    return err", "}"}) }),
        s("fmt", { t("fmt.Println("), i(1), t(")") }),
      })

      -- Rust
      ls.add_snippets("rust", {
        s("fn", { t("fn "), i(1, "name"), t("("), i(2), t(") -> "), i(3, "()"), t({" {", "    "}), i(0), t({"", "}"}) }),
        s("main", { t({"fn main() {", "    "}), i(0), t({"", "}"}) }),
        s("struct", { t("struct "), i(1, "Name"), t({" {", "    "}), i(0), t({"", "}"}) }),
        s("enum", { t("enum "), i(1, "Name"), t({" {", "    "}), i(0), t({"", "}"}) }),
        s("impl", { t("impl "), i(1, "Name"), t({" {", "    "}), i(0), t({"", "}"}) }),
        s("match", { t("match "), i(1, "value"), t({" {", "    "}), i(2), t({" => {},", "}"}) }),
        s("if", { t("if "), i(1, "condition"), t({" {", "    "}), i(0), t({"", "}"}) }),
        s("for", { t("for "), i(1, "item"), t(" in "), i(2, "iterator"), t({" {", "    "}), i(0), t({"", "}"}) }),
        s("println", { t("println!(\""), i(1), t("\");") }),
        s("vec", { t("vec!["), i(1), t("]") }),
        s("use", { t("use "), i(1), t(";") }),
      })

      -- PHP
      ls.add_snippets("php", {
        s("php", { t("<?php"), t({"", ""}), i(0) }),
        s("class", { t("class "), i(1, "ClassName"), t({"", "{", "    "}), i(0), t({"", "}"}) }),
        s("function", { t("function "), i(1, "name"), t("("), i(2), t(")"), t({"", "{", "    "}), i(0), t({"", "}"}) }),
        s("method", { t("public function "), i(1, "name"), t("("), i(2), t(")"), t({"", "{", "    "}), i(0), t({"", "}"}) }),
        s("echo", { t("echo "), i(1), t(";") }),
        s("var", { t("$"), i(1, "variable"), t(" = "), i(2), t(";") }),
        s("array", { t("$"), i(1, "array"), t(" = ["), i(2), t("];") }),
        s("foreach", { t("foreach ($"), i(1, "array"), t(" as $"), i(2, "item"), t(") {"), t({"", "    "}), i(0), t({"", "}"}) }),
        s("if", { t("if ("), i(1, "condition"), t(") {"), t({"", "    "}), i(0), t({"", "}"}) }),
        s("try", { t({"try {", "    "}), i(1), t({"", "} catch (Exception $e) {", "    "}), i(2), t({"", "}"}) }),
      })

      -- HTML
      ls.add_snippets("html", {
        s("html5", { t({"<!DOCTYPE html>", "<html lang=\"en\">", "<head>", "    <meta charset=\"UTF-8\">", "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">", "    <title>"}), i(1, "Document"), t({"</title>", "</head>", "<body>", "    "}), i(0), t({"", "</body>", "</html>"}) }),
        s("div", { t("<div"), i(1), t(">"), i(2), t("</div>") }),
        s("p", { t("<p>"), i(1), t("</p>") }),
        s("h1", { t("<h1>"), i(1), t("</h1>") }),
        s("h2", { t("<h2>"), i(1), t("</h2>") }),
        s("a", { t("<a href=\""), i(1), t("\">"), i(2), t("</a>") }),
        s("img", { t("<img src=\""), i(1), t("\" alt=\""), i(2), t("\">") }),
        s("ul", { t({"<ul>", "    <li>"}), i(1), t({"</li>", "</ul>"}) }),
        s("ol", { t({"<ol>", "    <li>"}), i(1), t({"</li>", "</ol>"}) }),
        s("form", { t({"<form>", "    "}), i(1), t({"", "</form>"}) }),
        s("input", { t("<input type=\""), i(1, "text"), t("\" name=\""), i(2), t("\">") }),
        s("button", { t("<button>"), i(1), t("</button>") }),
      })

      -- CSS
      ls.add_snippets("css", {
        s("flex", { t({"display: flex;", "justify-content: "}), i(1, "center"), t(";"), t({"", "align-items: "}), i(2, "center"), t(";") }),
        s("grid", { t({"display: grid;", "grid-template-columns: "}), i(1, "1fr 1fr"), t(";"), t({"", "gap: "}), i(2, "1rem"), t(";") }),
        s("center", { t({"display: flex;", "justify-content: center;", "align-items: center;"}) }),
        s("absolute", { t({"position: absolute;", "top: "}), i(1, "0"), t(";"), t({"", "left: "}), i(2, "0"), t(";") }),
        s("relative", { t("position: relative;") }),
        s("fixed", { t("position: fixed;") }),
        s("media", { t("@media ("), i(1, "max-width: 768px"), t(") {"), t({"", "    "}), i(0), t({"", "}"}) }),
        s("keyframes", { t("@keyframes "), i(1, "animation"), t({" {", "    0% { "}), i(2), t({" }", "    100% { "}), i(3), t({" }", "}"}) }),
        s("transition", { t("transition: "), i(1, "all"), t(" "), i(2, "0.3s"), t(" "), i(3, "ease"), t(";") }),
        s("transform", { t("transform: "), i(1, "translateX(0)"), t(";") }),
      })

      -- SQL
      ls.add_snippets("sql", {
        s("select", { t("SELECT "), i(1, "*"), t(" FROM "), i(2, "table"), t(";") }),
        s("insert", { t("INSERT INTO "), i(1, "table"), t(" ("), i(2, "columns"), t(") VALUES ("), i(3, "values"), t(");") }),
        s("update", { t("UPDATE "), i(1, "table"), t(" SET "), i(2, "column = value"), t(" WHERE "), i(3, "condition"), t(";") }),
        s("delete", { t("DELETE FROM "), i(1, "table"), t(" WHERE "), i(2, "condition"), t(";") }),
        s("create", { t("CREATE TABLE "), i(1, "table_name"), t({" (", "    "}), i(2, "id INT PRIMARY KEY"), t({"", ");"}) }),
        s("join", { t("JOIN "), i(1, "table"), t(" ON "), i(2, "condition") }),
        s("where", { t("WHERE "), i(1, "condition") }),
        s("order", { t("ORDER BY "), i(1, "column"), t(" "), i(2, "ASC") }),
        s("group", { t("GROUP BY "), i(1, "column") }),
      })

      -- Lua
      ls.add_snippets("lua", {
        s("req", { t("local "), i(1, "module"), t(" = require(\""), i(2, "module"), t("\")") }),
        s("func", { t("local function "), i(1, "name"), t("("), i(2), t(")"), t({"", "  "}), i(0), t({"", "end"}) }),
        s("if", { t("if "), i(1, "condition"), t({" then", "  "}), i(0), t({"", "end"}) }),
        s("for", { t("for "), i(1, "i"), t(" = 1, "), i(2, "10"), t({" do", "  "}), i(0), t({"", "end"}) }),
        s("forp", { t("for "), i(1, "k"), t(", "), i(2, "v"), t(" in pairs("), i(3, "table"), t({") do", "  "}), i(0), t({"", "end"}) }),
        s("fori", { t("for "), i(1, "i"), t(", "), i(2, "v"), t(" in ipairs("), i(3, "table"), t({") do", "  "}), i(0), t({"", "end"}) }),
        s("while", { t("while "), i(1, "condition"), t({" do", "  "}), i(0), t({"", "end"}) }),
        s("table", { t("local "), i(1, "table"), t(" = {"), i(2), t("}") }),
      })

      -- Angular (TypeScript)
      ls.add_snippets("typescript", {
        s("component", { t({"import { Component } from '@angular/core';", "", "@Component({", "  selector: 'app-"}), i(1, "component"), t({"',", "  templateUrl: './"}), f(function(args) return args[1][1] end, {1}), t({".component.html',", "  styleUrls: ['./"}), f(function(args) return args[1][1] end, {1}), t({".component.css']", "})", "export class "}), f(function(args) return args[1][1]:gsub("^%l", string.upper) end, {1}), t({"Component {", "  "}), i(0), t({"", "}"}) }),
        s("service", { t({"import { Injectable } from '@angular/core';", "", "@Injectable({", "  providedIn: 'root'", "})", "export class "}), i(1, "Service"), t({"Service {", "  "}), i(0), t({"", "}"}) }),
        s("ngif", { t("*ngIf=\""), i(1, "condition"), t("\"") }),
        s("ngfor", { t("*ngFor=\"let "), i(1, "item"), t(" of "), i(2, "items"), t("\"") }),
      })

      -- Vue.js
      ls.add_snippets("vue", {
        s("template", { t({"<template>", "  <div>", "    "}), i(1), t({"", "  </div>", "</template>", "", "<script>", "export default {", "  name: '"}), i(2, "Component"), t({"',", "  "}), i(0), t({"", "}", "</script>", "", "<style scoped>", "</style>"}) }),
        s("vfor", { t("v-for=\""), i(1, "item"), t(" in "), i(2, "items"), t("\" :key=\""), i(3, "item.id"), t("\"") }),
        s("vif", { t("v-if=\""), i(1, "condition"), t("\"") }),
        s("vmodel", { t("v-model=\""), i(1, "data"), t("\"") }),
      })

      -- Node.js
      ls.add_snippets("javascript", {
        s("require", { t("const "), i(1, "module"), t(" = require('"), i(2, "module"), t("');") }),
        s("exports", { t("module.exports = "), i(1), t(";") }),
        s("express", { t({"const express = require('express');", "const app = express();", "", "app.get('/', (req, res) => {", "  res.send('Hello World!');", "});", "", "app.listen("}), i(1, "3000"), t(", () => {"), t({"", "  console.log('Server running on port "}), f(function(args) return args[1][1] end, {1}), t({"');", "});"}) }),
      })
      
      -- Bash/Shell (Epic snippets)
      ls.add_snippets("sh", {
        s("shebang", { t("#!/bin/bash"), t({"", "set -euo pipefail", ""}), i(0) }),
        s("strict", { t({"set -euo pipefail", "IFS=$'\\n\\t'"}) }),
        s("if", { t("if [[ "), i(1, "condition"), t({" ]]; then", "  "}), i(2), t({"", "fi"}) }),
        s("elif", { t("elif [[ "), i(1, "condition"), t({" ]]; then", "  "}), i(0) }),
        s("for", { t("for "), i(1, "item"), t(" in "), i(2, "${array[@]}"), t({"; do", "  "}), i(3), t({"", "done"}) }),
        s("while", { t("while [[ "), i(1, "condition"), t({" ]]; do", "  "}), i(2), t({"", "done"}) }),
        s("func", { t(""), i(1, "function_name"), t({"() {", "  local "}), i(2, "param"), t("=$1"), t({"", "  "}), i(3), t({"", "}"}) }),
        s("case", { t("case $"), i(1, "var"), t({" in", "  "}), i(2, "pattern1"), t({")", "    "}), i(3, "echo \"Option 1\""), t({"", "    ;;", "  "}), i(4, "pattern2"), t({")", "    "}), i(5, "echo \"Option 2\""), t({"", "    ;;", "  *)", "    echo \"Unknown: $"}), f(function(args) return args[1][1] end, {1}), t({"\"", "    ;;", "esac"}) }),
        s("array", { t(""), i(1, "array"), t("=("), i(2), t(")") }),
        s("read", { t("read -p \""), i(1, "Enter value: "), t("\" "), i(2, "variable") }),
        s("readyn", { t({"read -p \""}), i(1, "Continue? (y/n): "), t({"\" yn", "case $yn in", "  [Yy]*) "}), i(2, "echo \"Yes\""), t({" ;;", "  [Nn]*) "}), i(3, "echo \"No\"; exit 1"), t({" ;;", "  *) echo \"Please answer yes or no.\" ;;", "esac"}) }),
        s("getopts", { t("while getopts \""), i(1, "h:v"), t("\" opt; do"), t({"", "  case $opt in", "    h) echo \"Help\" ;;", "    v) echo \"Version\" ;;", "    \\?) echo \"Invalid option\" >&2; exit 1 ;;", "  esac", "done"}) }),
        s("check", { t("if [[ ! -"), i(1, "f"), t(" "), i(2, "file"), t({" ]]; then", "  echo \"Error: File not found\" >&2", "  exit 1", "fi"}) }),
        s("exists", { t("[[ -"), i(1, "f"), t(" "), i(2, "file"), t(" ]]"}) }),
        s("empty", { t("[[ -z $"), i(1, "variable"), t(" ]]"}) }),
        s("nonempty", { t("[[ -n $"), i(1, "variable"), t(" ]]"}) }),
        s("numeric", { t("[[ $"), i(1, "var"), t(" =~ ^[0-9]+$ ]]"}) }),
        s("log", { t("echo \"$(date '+%Y-%m-%d %H:%M:%S'): "), i(1, "message"), t("\" | tee -a "), i(2, "logfile.log") }),
        s("error", { t("echo \"ERROR: "), i(1, "message"), t("\" >&2") }),
        s("warn", { t("echo \"WARNING: "), i(1, "message"), t("\" >&2") }),
        s("info", { t("echo \"INFO: "), i(1, "message"), t("\"") }),
        s("debug", { t("[[ $DEBUG ]] && echo \"DEBUG: "), i(1, "message"), t("\"") }),
        s("trap", { t("trap '"), i(1, "cleanup"), t("' EXIT") }),
        s("cleanup", { t({"cleanup() {", "  echo \"Cleaning up...\"", "  "}), i(1), t({"", "}"}) }),
        s("usage", { t({"usage() {", "  echo \"Usage: $0 "}), i(1, "[options]"), t({"\"", "  echo \"Options:\"", "  echo \"  -h    Show help\"", "  exit 1", "}"}) }),
        s("colors", { t({"RED='\\033[0;31m'", "GREEN='\\033[0;32m'", "YELLOW='\\033[1;33m'", "BLUE='\\033[0;34m'", "NC='\\033[0m' # No Color"}) }),
        s("progress", { t("for i in {1.."), i(1, "100"), t("}; do"), t({"", "  echo -ne \"Progress: $i%\\r\"", "  sleep 0.1", "done", "echo"}) }),
        s("parallel", { t(""), i(1, "command1"), t(" &"), t({"", ""}), i(2, "command2"), t(" &"), t({"", "wait"}) }),
        s("lock", { t("LOCKFILE=\"/tmp/"), i(1, "script"), t(".lock\""), t({"", "if [[ -f $LOCKFILE ]]; then", "  echo \"Script already running\" >&2", "  exit 1", "fi", "touch $LOCKFILE", "trap 'rm -f $LOCKFILE' EXIT"}) }),
        s("config", { t("CONFIG_FILE=\""), i(1, "config.conf"), t("\""), t({"", "[[ -f $CONFIG_FILE ]] && source $CONFIG_FILE"}) }),
        s("spinner", { t({"spinner() {", "  local pid=$!", "  local delay=0.1", "  local spinstr='|/-\\\\'", "  while [[ \"$(ps a | awk '{print $1}' | grep $pid)\" ]]; do", "    local temp=${spinstr#?}", "    printf \" [%c]  \" \"$spinstr\"", "    local spinstr=$temp${spinstr%\"$temp\"}", "    sleep $delay", "  done", "  printf \"    \\b\\b\\b\\b\"", "}"}) }),
      })
      
      -- Bash aliases for common file types
      ls.add_snippets("bash", {
        s("shebang", { t("#!/bin/bash"), t({"", "set -euo pipefail", ""}), i(0) }),
      })
      
      ls.add_snippets("zsh", {
        s("shebang", { t("#!/bin/zsh"), t({"", ""}), i(0) }),
      })
    end,
  },
}