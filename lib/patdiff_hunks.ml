open! Core.Std
open! Import

type t = string Patience_diff.Hunk.t list

let iter' ~f_hunk_break ~f_line (hunks : t) =
  List.iter hunks ~f:(fun hunk ->
    f_hunk_break hunk;
    List.iter hunk.ranges ~f:(function
      | Same r -> Array.iter r ~f:(fun (_, new_) -> f_line new_)
      | Old r | New r | Unified r -> Array.iter r ~f:f_line
      | Replace (ar1, ar2) ->
        Array.iter ar1 ~f:f_line;
        Array.iter ar2 ~f:f_line))
;;

let iter ~f_hunk_break ~f_line (hunks : t) =
  iter' ~f_line hunks ~f_hunk_break:(fun hunk ->
    f_hunk_break (hunk.mine_start, hunk.mine_size) (hunk.other_start, hunk.other_size))
;;
