MODULE GripperMotion_left

! Software License Agreement (BSD License)
!
! Copyright (c) 2012, Edward Venator, Case Western Reserve University
! Copyright (c) 2012, Jeremy Zoss, Southwest Research Institute
! All rights reserved.
!
! Redistribution and use in source and binary forms, with or without modification,
! are permitted provided that the following conditions are met:
!
!   Redistributions of source code must retain the above copyright notice, this
!       list of conditions and the following disclaimer.
!   Redistributions in binary form must reproduce the above copyright notice, this
!       list of conditions and the following disclaimer in the documentation
!       and/or other materials provided with the distribution.
!   Neither the name of the Case Western Reserve University nor the names of its contributors
!       may be used to endorse or promote products derived from this software without
!       specific prior written permission.
!
! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
! EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
! OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
! SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
! INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
! TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
! BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
! CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
! WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


PROC main()
    VAR num grasp_pos;
    
    Hand_JogOutward;
    WaitTime 4;
    Hand_JogInward;
    WaitTime 4;
    Hand_DoCalibrate;
    Hand_Initialize \maxSpd:=20, \holdForce:=10;
    Hand_MoveTo(10);
    grasp_pos:=5;
    
    
    WHILE true DO
        ! Check for an updated setpoint. 
        grasp_pos := next_grasp_target.left;
        current_gripper_left := Hand_GetActualPos();

        IF(grasp_pos >= 0) THEN
            TPWrite "Left gripper goal = "\num:=grasp_pos;
            Hand_MoveTo grasp_pos\NoWait;
        ENDIF

        !WaitTime 0.1;
    ENDWHILE
ERROR
    ErrWrite \W, "Gripper Motion Error", "Error executing motion.  Aborting trajectory.";
ENDPROC


ENDMODULE
