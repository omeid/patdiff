open! Core.Std
open! Import

module Rule = struct

  let apply s ~rule ~refined =
    if refined then failwith "refined is not supported in Ascii mode";
    Ansi_output.Rule.apply s ~rule:(Patdiff_format.Rule.strip_styles rule) ~refined:false
  ;;

end

let print ~print_global_header ~file_names ~rules ~print ~location_style hunks =
  let rules = Patdiff_format.Rules.strip_styles rules in
  Ansi_output.print ~print_global_header ~file_names ~rules ~print ~location_style hunks
;;