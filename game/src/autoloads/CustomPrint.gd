extends Node

func collection_to_str(__collection, __array_indent_setting := 0, __quotes_removed := true, __unescaped := true) -> String:
	assert(__collection is Dictionary or __collection is Array)
	var __collection_as_str : String = to_json(__collection)

	var __nest_history_str := ""
	var __k_Array := "Array "
	var __k_Dict := "Dict "

	var __opening_brackets := ["{", "["]
	var __closing_brackets := ["}", "]"]
	var __all_brackets := __opening_brackets + __closing_brackets

	var __d_quote := "\""
	var __s_quote := "'"
	var __LITERAL_newline := "\\n"
	var __LITERAL_tab := "\\t"

	var __inside_d_quote := false
	var __inside_s_quote := false

	var __indent_level := 0
	var __indention_array := []
	var __temp_str := ""

	for __c_char in __collection_as_str:
		match __c_char:
			__d_quote:
				__inside_d_quote = !__inside_d_quote
				__temp_str += __c_char
			__s_quote:
				__inside_s_quote = !__inside_s_quote
				__temp_str += __c_char

			",", "{", "}", "[", "]":
				if __inside_d_quote or __inside_s_quote:
					__temp_str += __c_char
				else:
					if __closing_brackets.has(__c_char):
						__temp_str += str("\n", __c_char)
					else:
						__temp_str += str(__c_char, "\n")
			_:
				__temp_str += __c_char

	__temp_str = __temp_str.replace("\n,", ",")
	__temp_str = __temp_str.replace("\n\n", "\n")

	var __collection_as_str_lines : Array = __temp_str.split("\n")

	for __c_line in __collection_as_str_lines:
		var __indent_str := "\t".repeat(__indent_level)

		var __first_char : String = __c_line.left(1)
		var __last_char : String = __c_line.right(__c_line.length() - 1)

		if __first_char.empty():
			if !__c_line.empty():
				assert(false)

		if __opening_brackets.has(__first_char) \
		or __opening_brackets.has(__last_char):
			__indent_level += 1
		elif __closing_brackets.has(__first_char):
			__indent_level -= 1
			__indent_str = "\t".repeat(__indent_level)

		__indention_array.append(__indent_str)

	assert(__indention_array.size() == __collection_as_str_lines.size())
	var __line_count := __collection_as_str_lines.size()

	var __formatted_line_array := []

	for __n in __line_count:
		var __c_collection_str_line : String = __collection_as_str_lines[__n]
		var __c_indent_str : String = __indention_array[__n]
		__formatted_line_array.append(str(__c_indent_str, __c_collection_str_line))

	var __formatted_str := ""

	for __formatted_line in __formatted_line_array:
		__formatted_str += __formatted_line + "\n"

	if __unescaped:
		var __all_broken_lines := []
		var __line_broken_dict_str := ""

		var __all_unbroken_lines := __formatted_str.split("\n")

		for __unbroken_line in __all_unbroken_lines:

			var __unbroken_line_first_char : String = __unbroken_line.left(1)
			var __unbroken_line_last_char : String = __unbroken_line.right(__unbroken_line.length() - 1)

			match __unbroken_line_last_char:
				"{":
					__nest_history_str += __k_Dict
				"[":
					__nest_history_str += __k_Array

			if __unbroken_line.ends_with("}") or __unbroken_line.ends_with("},"):
				__nest_history_str = __nest_history_str.trim_suffix(__k_Dict)

			if __unbroken_line.ends_with("]") or __unbroken_line.ends_with("],"):
				__nest_history_str = __nest_history_str.trim_suffix(__k_Array)

			if !__LITERAL_newline in __unbroken_line:
				__all_broken_lines.append(__unbroken_line)
			else:
				var __dedented_line : String = __unbroken_line.dedent()
				var __content_pos : int = __unbroken_line.find(__dedented_line)
				var __indention : String = __unbroken_line.left(__content_pos)

				var __line_break_spacer := \
						str("\n", __indention, "\t")

				if __nest_history_str.ends_with(__k_Dict):
					var __multiline_str := ""

					if ":" in __unbroken_line:
						var __first_colon_pos : int = __unbroken_line.find(":")
						assert(__first_colon_pos != -1)
						__multiline_str = __unbroken_line.right(__first_colon_pos + 1)
					else:
						__multiline_str = __unbroken_line.dedent()

					__unbroken_line = __unbroken_line.replace(__multiline_str, __line_break_spacer + __multiline_str)

				if __nest_history_str.ends_with(__k_Array):
					match __array_indent_setting:
						0:
							"hanging indention"
						1:
							"inline block"
							__line_break_spacer = __line_break_spacer.trim_suffix("\t")
						2:
							"indented block"
							__unbroken_line = __unbroken_line.replace(__indention, __indention + "\t")
						_:
							assert(false)

				var __line_broken_str : String = \
					__unbroken_line.replace(__LITERAL_newline, __line_break_spacer)

				__line_broken_str = __line_broken_str.replace(__LITERAL_tab, "")
				__all_broken_lines.append(__line_broken_str)

		if !__all_broken_lines.empty():
			for __broken_line in __all_broken_lines:
				__line_broken_dict_str += __broken_line + "\n"

			__formatted_str = __line_broken_dict_str

	if __quotes_removed:
		__formatted_str = __formatted_str.replace(__d_quote, "")

	match typeof(__collection):
		TYPE_ARRAY:
			__nest_history_str = __nest_history_str.trim_suffix(__k_Array)
		TYPE_DICTIONARY:
			__nest_history_str = __nest_history_str.trim_suffix(__k_Dict)
		_:
			assert(false)

	assert(__nest_history_str.empty())
	return __formatted_str

func print_dict_pretty(__dict : Dictionary, __array_indent_setting := 0, __quotes_removed := true, __unescaped := true)-> void:
	print(collection_to_str(__dict, __array_indent_setting, __quotes_removed, __unescaped))

func print_array_pretty(__array : Array, __array_indent_setting := 0, __quotes_removed := true, __unescaped := true)-> void:
	print(collection_to_str(__array, __array_indent_setting, __quotes_removed, __unescaped))
