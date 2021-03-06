(*  Title:      HOL/HOLCF/IOA/ABP/Action.thy
    Author:     Olaf Müller
*)

section \<open>The set of all actions of the system\<close>

theory Action
imports Packet
begin

datatype 'm action =
    Next | S_msg 'm | R_msg 'm
  | S_pkt "'m packet" | R_pkt "'m packet"
  | S_ack bool | R_ack bool

end
