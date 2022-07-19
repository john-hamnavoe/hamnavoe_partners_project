# frozen_string_literal: true

module ApplicationHelper
  include PagyHelper
  include Frontend::TableHelper


  def test_case_status_icon(test_case)
    if test_case.active_cases.count.positive?
      content_tag(:svg, class: "h-6 w-6 text-red-700", xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", "stroke-width": "2") do  
        content_tag(:path, nil, "stroke-linecap": "round", "stroke-linejoin": "round",  d: "M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z") + 
        content_tag(:title, "Blocked By Cases")
      end  
    elsif !test_case.tests_executed
      content_tag(:svg, class: "h-6 w-6 text-yellow-400", xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", "stroke-width": "2") do  
        content_tag(:path, nil, "stroke-linecap": "round", "stroke-linejoin": "round",  d: "M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636") + 
        content_tag(:title, "Tests Not Executable")
      end  
    elsif test_case.volume_test_required && !test_case.volume_tests_executed
      content_tag(:svg, class: "h-6 w-6 text-gray-600", xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", "stroke-width": "2") do
        content_tag(:path, nil, "stroke-linecap": "round", "stroke-linejoin": "round", d: "M5.586 15H4a1 1 0 01-1-1v-4a1 1 0 011-1h1.586l4.707-4.707C10.923 3.663 12 4.109 12 5v14c0 .891-1.077 1.337-1.707.707L5.586 15z", "clip-rule": "evenodd") +
          content_tag(:path, nil, "stroke-linecap": "round", "stroke-linejoin": "round", d: "M17 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2") + 
          content_tag(:title, "Volume Tests Not Executable")
      end      
    else
      content_tag(:svg, class: "h-6 w-6 text-green-700", xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", "stroke-width": "2") do  
        content_tag(:path, nil, "stroke-linecap": "round", "stroke-linejoin": "round",  d: "M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z") + 
        content_tag(:title, "Passing")
      end        
    end
  end
end
