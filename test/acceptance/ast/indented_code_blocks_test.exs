defmodule Acceptance.Ast.IndentedCodeBlocksTest do
  use ExUnit.Case
  import Support.Helpers, only: [as_ast: 1, parse_html: 1]

  @moduletag :ast

  describe "Indented code blocks" do
    test "simple (but easy?)" do
      markdown = "    a simple\n      indented code block\n"
      html     = "<pre><code>a simple\n  indented code block</code></pre>\n"
      ast      = parse_html(html)
      messages = []

      assert as_ast(markdown) == {:ok, [ast], messages}
    end

    test "code is soo verbatim" do
      markdown = "    <a/>\n    *hi*\n\n    - one\n"
      html     = "<pre><code>&lt;a/&gt;\n*hi*\n\n- one</code></pre>\n"
      ast      = parse_html(html)
      messages = []

      assert as_ast(markdown) == {:ok, [ast], messages}
    end

    test "chunky bacon (RIP: Why)" do
      markdown = "    chunk1\n\n    chunk2\n  \n \n \n    chunk3\n"
      html     = "<pre><code>chunk1\n\nchunk2\n\n\n\nchunk3</code></pre>\n"
      ast      = parse_html(html)
      messages = []

      assert as_ast(markdown) == {:ok, [ast], messages}
    end

    test "foo and bar (now you are surprised!)" do
      markdown = "    foo\nbar\n"
      html     = "<pre><code>foo</code></pre>\n<p>bar</p>\n"
      ast      = parse_html(html)
      messages = []

      assert as_ast(markdown) == {:ok, ast, messages}
    end

    test "not the alpha, not the omega (gamma maybe?)" do
      markdown = "\n    \n    foo\n    \n\n"
      html = "<pre><code>foo</code></pre>\n"
      ast      = parse_html(html)
      messages = []
      assert as_ast(markdown) == {:ok, [ast], messages}
    end
  end
end

# SPDX-License-Identifier: Apache-2.0
