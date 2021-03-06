module Treetop
  module Compiler    
    class Nonterminal < AtomicExpression
      def compile(address, builder, parent_expression = nil)
        super
        use_vars :result
        assign_result text_value == 'super' ? 'super' : "_nt_#{text_value}"
        extend_result_with_declared_module
        extend_result_with_inline_module parent_expression
      end
    end
  end
end
