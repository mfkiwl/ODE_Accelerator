module FSM_END_EULAR (
input clk,rst_sync,F,R,D,
output [1:0] outp
);

// States
// {end of row, data ready} 
localparam  State0 = 2'b00, State1 = 2'b10 , State2 = 2'b11;
reg[1:0] current_state;

assign outp = current_state; 


always @(posedge clk)
begin
    if(rst_sync == 1'b1)
        begin
            current_state <= State0;
        end
    else
    case(current_state)
        State0:
            begin
                if(F == 1'b1)
                    begin
                        current_state <= State1;
                    end
            end
        State1:
            begin
                if(R == 1'b1)
                    begin
                        current_state <= State2;
                    end
            end
        State2:
            begin
                if(D == 1'b1)
                    begin
                        current_state <= State0;
                    end
            end
    endcase
    //outp <= current_state;
end

endmodule