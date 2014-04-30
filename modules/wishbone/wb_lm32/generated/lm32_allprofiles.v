module lm32_top_full (
    clk_i,
    rst_i,
    interrupt,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset = 32'h00000000;
parameter sdb_address = 32'h00000000;
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_cpu_full 
	#(
		.eba_reset(eba_reset),
    .sdb_address(sdb_address)
	) cpu (
    .clk_i                 (clk_i),
    .rst_i                 (rst_i),
    .interrupt             (interrupt),
    .I_DAT_I               (I_DAT_I),
    .I_ACK_I               (I_ACK_I),
    .I_ERR_I               (I_ERR_I),
    .I_RTY_I               (I_RTY_I),
    .D_DAT_I               (D_DAT_I),
    .D_ACK_I               (D_ACK_I),
    .D_ERR_I               (D_ERR_I),
    .D_RTY_I               (D_RTY_I),
    .I_DAT_O               (I_DAT_O),
    .I_ADR_O               (I_ADR_O),
    .I_CYC_O               (I_CYC_O),
    .I_SEL_O               (I_SEL_O),
    .I_STB_O               (I_STB_O),
    .I_WE_O                (I_WE_O),
    .I_CTI_O               (I_CTI_O),
    .I_LOCK_O              (I_LOCK_O),
    .I_BTE_O               (I_BTE_O),
    .D_DAT_O               (D_DAT_O),
    .D_ADR_O               (D_ADR_O),
    .D_CYC_O               (D_CYC_O),
    .D_SEL_O               (D_SEL_O),
    .D_STB_O               (D_STB_O),
    .D_WE_O                (D_WE_O),
    .D_CTI_O               (D_CTI_O),
    .D_LOCK_O              (D_LOCK_O),
    .D_BTE_O               (D_BTE_O)
    );
endmodule
module lm32_mc_arithmetic_full (
    clk_i,
    rst_i,
    stall_d,
    kill_x,
    divide_d,
    modulus_d,
    operand_0_d,
    operand_1_d,
    result_x,
    divide_by_zero_x,
    stall_request_x
    );
input clk_i;                                    
input rst_i;                                    
input stall_d;                                  
input kill_x;                                   
input divide_d;                                 
input modulus_d;                                
input [ (32-1):0] operand_0_d;
input [ (32-1):0] operand_1_d;
output [ (32-1):0] result_x;               
reg    [ (32-1):0] result_x;
output divide_by_zero_x;                        
reg    divide_by_zero_x;
output stall_request_x;                         
wire   stall_request_x;
reg [ (32-1):0] p;                         
reg [ (32-1):0] a;
reg [ (32-1):0] b;
wire [32:0] t;
reg [ 2:0] state;                 
reg [5:0] cycles;                               
assign stall_request_x = state !=  3'b000;
assign t = {p[ 32-2:0], a[ 32-1]} - b;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        cycles <= {6{1'b0}};
        p <= { 32{1'b0}};
        a <= { 32{1'b0}};
        b <= { 32{1'b0}};
        divide_by_zero_x <=  1'b0;
        result_x <= { 32{1'b0}};
        state <=  3'b000;
    end
    else
    begin
        divide_by_zero_x <=  1'b0;
        case (state)
         3'b000:
        begin
            if (stall_d ==  1'b0)                 
            begin          
                cycles <=  32;
                p <= 32'b0;
                a <= operand_0_d;
                b <= operand_1_d;                    
                if (divide_d ==  1'b1)
                    state <=  3'b011 ;
                if (modulus_d ==  1'b1)
                    state <=  3'b010   ;
            end            
        end
         3'b011 :
        begin
            if (t[32] == 1'b0)
            begin
                p <= t[31:0];
                a <= {a[ 32-2:0], 1'b1};
            end
            else 
            begin
                p <= {p[ 32-2:0], a[ 32-1]};
                a <= {a[ 32-2:0], 1'b0};
            end
            result_x <= a;
            if ((cycles ==  32'd0) || (kill_x ==  1'b1))
            begin
                divide_by_zero_x <= b == { 32{1'b0}};
                state <=  3'b000;
            end
            cycles <= cycles - 1'b1;
        end
         3'b010   :
        begin
            if (t[32] == 1'b0)
            begin
                p <= t[31:0];
                a <= {a[ 32-2:0], 1'b1};
            end
            else 
            begin
                p <= {p[ 32-2:0], a[ 32-1]};
                a <= {a[ 32-2:0], 1'b0};
            end
            result_x <= p;
            if ((cycles ==  32'd0) || (kill_x ==  1'b1))
            begin
                divide_by_zero_x <= b == { 32{1'b0}};
                state <=  3'b000;
            end
            cycles <= cycles - 1'b1;
        end
        endcase
    end
end 
endmodule
module lm32_cpu_full (
    clk_i,
    rst_i,
    interrupt,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset =  32'h00000000;                           
parameter sdb_address =   32'h00000000;
parameter icache_associativity =  1;     
parameter icache_sets =  256;                       
parameter icache_bytes_per_line =  16;   
parameter icache_base_address =  32'h0;       
parameter icache_limit =  32'h7fffffff;                     
parameter dcache_associativity =  1;     
parameter dcache_sets =  256;                       
parameter dcache_bytes_per_line =  16;   
parameter dcache_base_address =  32'h0;       
parameter dcache_limit =  32'h7fffffff;                     
parameter watchpoints = 0;
parameter breakpoints = 0;
parameter interrupts =  32;                         
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
reg valid_a;                                    
reg valid_f;                                    
reg valid_d;                                    
reg valid_x;                                    
reg valid_m;                                    
reg valid_w;                                    
wire q_x;
wire [ (32-1):0] immediate_d;              
wire load_d;                                    
reg load_x;                                     
reg load_m;
wire load_q_x;
wire store_q_x;
wire q_m;
wire load_q_m;
wire store_q_m;
wire store_d;                                   
reg store_x;
reg store_m;
wire [ 1:0] size_d;                   
reg [ 1:0] size_x;
wire branch_d;                                  
wire branch_predict_d;                          
wire branch_predict_taken_d;                    
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_predict_address_d;   
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_d;
wire bi_unconditional;
wire bi_conditional;
reg branch_x;                                   
reg branch_predict_x;
reg branch_predict_taken_x;
reg branch_m;
reg branch_predict_m;
reg branch_predict_taken_m;
wire branch_mispredict_taken_m;                 
wire branch_flushX_m;                           
wire branch_reg_d;                              
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset_d;            
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_x;             
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_m;
wire [ 0:0] d_result_sel_0_d; 
wire [ 1:0] d_result_sel_1_d; 
wire x_result_sel_csr_d;                        
reg x_result_sel_csr_x;
wire q_d;
wire x_result_sel_mc_arith_d;                   
reg x_result_sel_mc_arith_x;
wire x_result_sel_sext_d;                       
reg x_result_sel_sext_x;
wire x_result_sel_logic_d;                      
wire x_result_sel_add_d;                        
reg x_result_sel_add_x;
wire m_result_sel_compare_d;                    
reg m_result_sel_compare_x;
reg m_result_sel_compare_m;
wire m_result_sel_shift_d;                      
reg m_result_sel_shift_x;
reg m_result_sel_shift_m;
wire w_result_sel_load_d;                       
reg w_result_sel_load_x;
reg w_result_sel_load_m;
reg w_result_sel_load_w;
wire w_result_sel_mul_d;                        
reg w_result_sel_mul_x;
reg w_result_sel_mul_m;
reg w_result_sel_mul_w;
wire x_bypass_enable_d;                         
reg x_bypass_enable_x;                          
wire m_bypass_enable_d;                         
reg m_bypass_enable_x;                          
reg m_bypass_enable_m;
wire sign_extend_d;                             
reg sign_extend_x;
wire write_enable_d;                            
reg write_enable_x;
wire write_enable_q_x;
reg write_enable_m;
wire write_enable_q_m;
reg write_enable_w;
wire write_enable_q_w;
wire read_enable_0_d;                           
wire [ (5-1):0] read_idx_0_d;          
wire read_enable_1_d;                           
wire [ (5-1):0] read_idx_1_d;          
wire [ (5-1):0] write_idx_d;           
reg [ (5-1):0] write_idx_x;            
reg [ (5-1):0] write_idx_m;
reg [ (5-1):0] write_idx_w;
wire [ (4 -1):0] csr_d;                     
reg  [ (4 -1):0] csr_x;                  
wire [ (3-1):0] condition_d;         
reg [ (3-1):0] condition_x;          
wire scall_d;                                   
reg scall_x;    
wire eret_d;                                    
reg eret_x;
wire eret_q_x;
wire csr_write_enable_d;                        
reg csr_write_enable_x;
wire csr_write_enable_q_x;
wire bus_error_d;                               
reg bus_error_x;
reg data_bus_error_exception_m;
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] memop_pc_w;
reg [ (32-1):0] d_result_0;                
reg [ (32-1):0] d_result_1;                
reg [ (32-1):0] x_result;                  
reg [ (32-1):0] m_result;                  
reg [ (32-1):0] w_result;                  
reg [ (32-1):0] operand_0_x;               
reg [ (32-1):0] operand_1_x;               
reg [ (32-1):0] store_operand_x;           
reg [ (32-1):0] operand_m;                 
reg [ (32-1):0] operand_w;                 
reg [ (32-1):0] reg_data_live_0;          
reg [ (32-1):0] reg_data_live_1;  
reg use_buf;                                    
reg [ (32-1):0] reg_data_buf_0;
reg [ (32-1):0] reg_data_buf_1;
wire [ (32-1):0] reg_data_0;               
wire [ (32-1):0] reg_data_1;               
reg [ (32-1):0] bypass_data_0;             
reg [ (32-1):0] bypass_data_1;             
wire reg_write_enable_q_w;
reg interlock;                                  
wire stall_a;                                   
wire stall_f;                                   
wire stall_d;                                   
wire stall_x;                                   
wire stall_m;                                   
wire adder_op_d;                                
reg adder_op_x;                                 
reg adder_op_x_n;                               
wire [ (32-1):0] adder_result_x;           
wire adder_overflow_x;                          
wire adder_carry_n_x;                           
wire [ 3:0] logic_op_d;           
reg [ 3:0] logic_op_x;            
wire [ (32-1):0] logic_result_x;           
wire [ (32-1):0] sextb_result_x;           
wire [ (32-1):0] sexth_result_x;           
wire [ (32-1):0] sext_result_x;            
wire direction_d;                               
reg direction_x;                                        
wire [ (32-1):0] shifter_result_m;         
wire [ (32-1):0] multiplier_result_w;      
wire divide_d;                                  
wire divide_q_d;
wire modulus_d;
wire modulus_q_d;
wire divide_by_zero_x;                          
wire mc_stall_request_x;                        
wire [ (32-1):0] mc_result_x;
wire [ (32-1):0] interrupt_csr_read_data_x;
wire [ (32-1):0] cfg;                      
wire [ (32-1):0] cfg2;                     
reg [ (32-1):0] csr_read_data_x;           
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;                       
wire [ (32-1):0] instruction_f;     
wire [ (32-1):0] instruction_d;     
wire iflush;                                    
wire icache_stall_request;                      
wire icache_restart_request;                    
wire icache_refill_request;                     
wire icache_refilling;                          
wire dflush_x;                                  
reg dflush_m;                                    
wire dcache_stall_request;                      
wire dcache_restart_request;                    
wire dcache_refill_request;                     
wire dcache_refilling;                          
wire [ (32-1):0] load_data_w;              
wire stall_wb_load;                             
wire raw_x_0;                                   
wire raw_x_1;                                   
wire raw_m_0;                                   
wire raw_m_1;                                   
wire raw_w_0;                                   
wire raw_w_1;                                   
wire cmp_zero;                                  
wire cmp_negative;                              
wire cmp_overflow;                              
wire cmp_carry_n;                               
reg condition_met_x;                            
reg condition_met_m;
wire branch_taken_x;                            
wire branch_taken_m;                            
wire kill_f;                                    
wire kill_d;                                    
wire kill_x;                                    
wire kill_m;                                    
wire kill_w;                                    
reg [ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8] eba;                 
reg [ (3-1):0] eid_x;                      
wire exception_x;                               
reg exception_m;
reg exception_w;
wire exception_q_w;
wire interrupt_exception;                       
wire instruction_bus_error_exception;           
wire data_bus_error_exception;                  
wire divide_by_zero_exception;                  
wire system_call_exception;                     
reg data_bus_error_seen;                        
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_instruction_unit_full #(
    .eba_reset              (eba_reset),
    .associativity          (icache_associativity),
    .sets                   (icache_sets),
    .bytes_per_line         (icache_bytes_per_line),
    .base_address           (icache_base_address),
    .limit                  (icache_limit)
  ) instruction_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_f                (stall_f),
    .stall_d                (stall_d),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .valid_f                (valid_f),
    .valid_d                (valid_d),
    .kill_f                 (kill_f),
    .branch_predict_taken_d (branch_predict_taken_d),
    .branch_predict_address_d (branch_predict_address_d),
    .branch_taken_x         (branch_taken_x),
    .branch_target_x        (branch_target_x),
    .exception_m            (exception_m),
    .branch_taken_m         (branch_taken_m),
    .branch_mispredict_taken_m (branch_mispredict_taken_m),
    .branch_target_m        (branch_target_m),
    .iflush                 (iflush),
    .dcache_restart_request (dcache_restart_request),
    .dcache_refill_request  (dcache_refill_request),
    .dcache_refilling       (dcache_refilling),
    .i_dat_i                (I_DAT_I),
    .i_ack_i                (I_ACK_I),
    .i_err_i                (I_ERR_I),
    .i_rty_i                (I_RTY_I),
    .pc_f                   (pc_f),
    .pc_d                   (pc_d),
    .pc_x                   (pc_x),
    .pc_m                   (pc_m),
    .pc_w                   (pc_w),
    .icache_stall_request   (icache_stall_request),
    .icache_restart_request (icache_restart_request),
    .icache_refill_request  (icache_refill_request),
    .icache_refilling       (icache_refilling),
    .i_dat_o                (I_DAT_O),
    .i_adr_o                (I_ADR_O),
    .i_cyc_o                (I_CYC_O),
    .i_sel_o                (I_SEL_O),
    .i_stb_o                (I_STB_O),
    .i_we_o                 (I_WE_O),
    .i_cti_o                (I_CTI_O),
    .i_lock_o               (I_LOCK_O),
    .i_bte_o                (I_BTE_O),
    .bus_error_d            (bus_error_d),
    .instruction_f          (instruction_f),
    .instruction_d          (instruction_d)
    );
lm32_decoder_full decoder (
    .instruction            (instruction_d),
    .d_result_sel_0         (d_result_sel_0_d),
    .d_result_sel_1         (d_result_sel_1_d),
    .x_result_sel_csr       (x_result_sel_csr_d),
    .x_result_sel_mc_arith  (x_result_sel_mc_arith_d),
    .x_result_sel_sext      (x_result_sel_sext_d),
    .x_result_sel_logic     (x_result_sel_logic_d),
    .x_result_sel_add       (x_result_sel_add_d),
    .m_result_sel_compare   (m_result_sel_compare_d),
    .m_result_sel_shift     (m_result_sel_shift_d),  
    .w_result_sel_load      (w_result_sel_load_d),
    .w_result_sel_mul       (w_result_sel_mul_d),
    .x_bypass_enable        (x_bypass_enable_d),
    .m_bypass_enable        (m_bypass_enable_d),
    .read_enable_0          (read_enable_0_d),
    .read_idx_0             (read_idx_0_d),
    .read_enable_1          (read_enable_1_d),
    .read_idx_1             (read_idx_1_d),
    .write_enable           (write_enable_d),
    .write_idx              (write_idx_d),
    .immediate              (immediate_d),
    .branch_offset          (branch_offset_d),
    .load                   (load_d),
    .store                  (store_d),
    .size                   (size_d),
    .sign_extend            (sign_extend_d),
    .adder_op               (adder_op_d),
    .logic_op               (logic_op_d),
    .direction              (direction_d),
    .divide                 (divide_d),
    .modulus                (modulus_d),
    .branch                 (branch_d),
    .bi_unconditional       (bi_unconditional),
    .bi_conditional         (bi_conditional),
    .branch_reg             (branch_reg_d),
    .condition              (condition_d),
    .scall                  (scall_d),
    .eret                   (eret_d),
    .csr_write_enable       (csr_write_enable_d)
    ); 
lm32_load_store_unit_full #(
    .associativity          (dcache_associativity),
    .sets                   (dcache_sets),
    .bytes_per_line         (dcache_bytes_per_line),
    .base_address           (dcache_base_address),
    .limit                  (dcache_limit)
  ) load_store_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .kill_x                 (kill_x),
    .kill_m                 (kill_m),
    .exception_m            (exception_m),
    .store_operand_x        (store_operand_x),
    .load_store_address_x   (adder_result_x),
    .load_store_address_m   (operand_m),
    .load_store_address_w   (operand_w[1:0]),
    .load_x                 (load_x),
    .store_x                (store_x),
    .load_q_x               (load_q_x),
    .store_q_x              (store_q_x),
    .load_q_m               (load_q_m),
    .store_q_m              (store_q_m),
    .sign_extend_x          (sign_extend_x),
    .size_x                 (size_x),
    .dflush                 (dflush_m),
    .d_dat_i                (D_DAT_I),
    .d_ack_i                (D_ACK_I),
    .d_err_i                (D_ERR_I),
    .d_rty_i                (D_RTY_I),
    .dcache_refill_request  (dcache_refill_request),
    .dcache_restart_request (dcache_restart_request),
    .dcache_stall_request   (dcache_stall_request),
    .dcache_refilling       (dcache_refilling),
    .load_data_w            (load_data_w),
    .stall_wb_load          (stall_wb_load),
    .d_dat_o                (D_DAT_O),
    .d_adr_o                (D_ADR_O),
    .d_cyc_o                (D_CYC_O),
    .d_sel_o                (D_SEL_O),
    .d_stb_o                (D_STB_O),
    .d_we_o                 (D_WE_O),
    .d_cti_o                (D_CTI_O),
    .d_lock_o               (D_LOCK_O),
    .d_bte_o                (D_BTE_O)
    );      
lm32_adder adder (
    .adder_op_x             (adder_op_x),
    .adder_op_x_n           (adder_op_x_n),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .adder_result_x         (adder_result_x),
    .adder_carry_n_x        (adder_carry_n_x),
    .adder_overflow_x       (adder_overflow_x)
    );
lm32_logic_op logic_op (
    .logic_op_x             (logic_op_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .logic_result_x         (logic_result_x)
    );
lm32_shifter shifter (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .direction_x            (direction_x),
    .sign_extend_x          (sign_extend_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .shifter_result_m       (shifter_result_m)
    );
lm32_multiplier multiplier (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .operand_0              (d_result_0),
    .operand_1              (d_result_1),
    .result                 (multiplier_result_w)    
    );
lm32_mc_arithmetic_full mc_arithmetic (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_d                (stall_d),
    .kill_x                 (kill_x),
    .divide_d               (divide_q_d),
    .modulus_d              (modulus_q_d),
    .operand_0_d            (d_result_0),
    .operand_1_d            (d_result_1),
    .result_x               (mc_result_x),
    .divide_by_zero_x       (divide_by_zero_x),
    .stall_request_x        (mc_stall_request_x)
    );
lm32_interrupt_full interrupt_unit (
    .clk_i                  (clk_i), 
    .rst_i                  (rst_i),
    .interrupt              (interrupt),
    .stall_x                (stall_x),
    .exception              (exception_q_w), 
    .eret_q_x               (eret_q_x),
    .csr                    (csr_x),
    .csr_write_data         (operand_1_x),
    .csr_write_enable       (csr_write_enable_q_x),
    .interrupt_exception    (interrupt_exception),
    .csr_read_data          (interrupt_csr_read_data_x)
    );
   wire [31:0] regfile_data_0, regfile_data_1;
   reg [31:0]  w_result_d;
   reg 	       regfile_raw_0, regfile_raw_0_nxt;
   reg 	       regfile_raw_1, regfile_raw_1_nxt;
   always @(reg_write_enable_q_w or write_idx_w or instruction_f)
     begin
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[25:21]))
	  regfile_raw_0_nxt = 1'b1;
	else
	  regfile_raw_0_nxt = 1'b0;
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[20:16]))
	  regfile_raw_1_nxt = 1'b1;
	else
	  regfile_raw_1_nxt = 1'b0;
     end
   always @(regfile_raw_0 or w_result_d or regfile_data_0)
     if (regfile_raw_0)
       reg_data_live_0 = w_result_d;
     else
       reg_data_live_0 = regfile_data_0;
   always @(regfile_raw_1 or w_result_d or regfile_data_1)
     if (regfile_raw_1)
       reg_data_live_1 = w_result_d;
     else
       reg_data_live_1 = regfile_data_1;
   always @(posedge clk_i  )
     if (rst_i ==  1'b1)
       begin
	  regfile_raw_0 <= 1'b0;
	  regfile_raw_1 <= 1'b0;
	  w_result_d <= 32'b0;
       end
     else
       begin
	  regfile_raw_0 <= regfile_raw_0_nxt;
	  regfile_raw_1 <= regfile_raw_1_nxt;
	  w_result_d <= w_result;
       end
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_0
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[25:21]),
      .rdata_o	(regfile_data_0)
      );
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_1
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[20:16]),
      .rdata_o	(regfile_data_1)
      );
assign reg_data_0 = use_buf ? reg_data_buf_0 : reg_data_live_0;
assign reg_data_1 = use_buf ? reg_data_buf_1 : reg_data_live_1;
assign raw_x_0 = (write_idx_x == read_idx_0_d) && (write_enable_q_x ==  1'b1);
assign raw_m_0 = (write_idx_m == read_idx_0_d) && (write_enable_q_m ==  1'b1);
assign raw_w_0 = (write_idx_w == read_idx_0_d) && (write_enable_q_w ==  1'b1);
assign raw_x_1 = (write_idx_x == read_idx_1_d) && (write_enable_q_x ==  1'b1);
assign raw_m_1 = (write_idx_m == read_idx_1_d) && (write_enable_q_m ==  1'b1);
assign raw_w_1 = (write_idx_w == read_idx_1_d) && (write_enable_q_w ==  1'b1);
always @(*)
begin
    if (   (   (x_bypass_enable_x ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_x_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_x_1 ==  1'b1))
               )
           )
        || (   (m_bypass_enable_m ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_m_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_m_1 ==  1'b1))
               )
           )
       )
        interlock =  1'b1;
    else
        interlock =  1'b0;
end
always @(*)
begin
    if (raw_x_0 ==  1'b1)        
        bypass_data_0 = x_result;
    else if (raw_m_0 ==  1'b1)
        bypass_data_0 = m_result;
    else if (raw_w_0 ==  1'b1)
        bypass_data_0 = w_result;
    else
        bypass_data_0 = reg_data_0;
end
always @(*)
begin
    if (raw_x_1 ==  1'b1)
        bypass_data_1 = x_result;
    else if (raw_m_1 ==  1'b1)
        bypass_data_1 = m_result;
    else if (raw_w_1 ==  1'b1)
        bypass_data_1 = w_result;
    else
        bypass_data_1 = reg_data_1;
end
   assign branch_predict_d = bi_unconditional | bi_conditional;
   assign branch_predict_taken_d = bi_unconditional ? 1'b1 : (bi_conditional ? instruction_d[15] : 1'b0);
   assign branch_target_d = pc_d + branch_offset_d;
   assign branch_predict_address_d = branch_predict_taken_d ? branch_target_d : pc_f;
always @(*)
begin
    d_result_0 = d_result_sel_0_d[0] ? {pc_f, 2'b00} : bypass_data_0; 
    case (d_result_sel_1_d)
     2'b00:      d_result_1 = { 32{1'b0}};
     2'b01:     d_result_1 = bypass_data_1;
     2'b10: d_result_1 = immediate_d;
    default:                        d_result_1 = { 32{1'bx}};
    endcase
end
assign sextb_result_x = {{24{operand_0_x[7]}}, operand_0_x[7:0]};
assign sexth_result_x = {{16{operand_0_x[15]}}, operand_0_x[15:0]};
assign sext_result_x = size_x ==  2'b00 ? sextb_result_x : sexth_result_x;
assign cmp_zero = operand_0_x == operand_1_x;
assign cmp_negative = adder_result_x[ 32-1];
assign cmp_overflow = adder_overflow_x;
assign cmp_carry_n = adder_carry_n_x;
always @(*)
begin
    case (condition_x)
     3'b000:   condition_met_x =  1'b1;
     3'b110:   condition_met_x =  1'b1;
     3'b001:    condition_met_x = cmp_zero;
     3'b111:   condition_met_x = !cmp_zero;
     3'b010:    condition_met_x = !cmp_zero && (cmp_negative == cmp_overflow);
     3'b101:   condition_met_x = cmp_carry_n && !cmp_zero;
     3'b011:   condition_met_x = cmp_negative == cmp_overflow;
     3'b100:  condition_met_x = cmp_carry_n;
    default:              condition_met_x = 1'bx;
    endcase 
end
always @(*)
begin
    x_result =   x_result_sel_add_x ? adder_result_x 
               : x_result_sel_csr_x ? csr_read_data_x
               : x_result_sel_sext_x ? sext_result_x
               : x_result_sel_mc_arith_x ? mc_result_x
               : logic_result_x;
end
always @(*)
begin
    m_result =   m_result_sel_compare_m ? {{ 32-1{1'b0}}, condition_met_m}
               : m_result_sel_shift_m ? shifter_result_m
               : operand_m; 
end
always @(*)
begin
    w_result =    w_result_sel_load_w ? load_data_w
                : w_result_sel_mul_w ? multiplier_result_w
                : operand_w;
end
assign branch_taken_x =      (stall_x ==  1'b0)
                          && (   (branch_x ==  1'b1)
                              && ((condition_x ==  3'b000) || (condition_x ==  3'b110))
                              && (valid_x ==  1'b1)
                              && (branch_predict_x ==  1'b0)
                             ); 
assign branch_taken_m =      (stall_m ==  1'b0) 
                          && (   (   (branch_m ==  1'b1) 
                                  && (valid_m ==  1'b1)
                                  && (   (   (condition_met_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b0)
					 )
				      || (   (condition_met_m ==  1'b0)
					  && (branch_predict_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b1)
					 )
				     )
                                 ) 
                              || (exception_m ==  1'b1)
                             );
assign branch_mispredict_taken_m =    (condition_met_m ==  1'b0)
                                   && (branch_predict_m ==  1'b1)
	   			   && (branch_predict_taken_m ==  1'b1);
assign branch_flushX_m =    (stall_m ==  1'b0)
                         && (   (   (branch_m ==  1'b1) 
                                 && (valid_m ==  1'b1)
			         && (   (condition_met_m ==  1'b1)
				     || (   (condition_met_m ==  1'b0)
					 && (branch_predict_m ==  1'b1)
					 && (branch_predict_taken_m ==  1'b1)
					)
				    )
			        )
			     || (exception_m ==  1'b1)
			    );
assign kill_f =    (   (valid_d ==  1'b1)
                    && (branch_predict_taken_d ==  1'b1)
		   )
                || (branch_taken_m ==  1'b1) 
                || (branch_taken_x ==  1'b1)
                || (icache_refill_request ==  1'b1) 
                || (dcache_refill_request ==  1'b1)
                ;
assign kill_d =    (branch_taken_m ==  1'b1) 
                || (branch_taken_x ==  1'b1)
                || (icache_refill_request ==  1'b1)     
                || (dcache_refill_request ==  1'b1)
                ;
assign kill_x =    (branch_flushX_m ==  1'b1) 
                || (dcache_refill_request ==  1'b1)
                ;
assign kill_m =     1'b0
                || (dcache_refill_request ==  1'b1)
                ;                
assign kill_w =     1'b0
                || (dcache_refill_request ==  1'b1)
                ;
assign instruction_bus_error_exception = (   (bus_error_x ==  1'b1)
                                          && (valid_x ==  1'b1)
                                         );
assign data_bus_error_exception = data_bus_error_seen ==  1'b1;
assign divide_by_zero_exception = divide_by_zero_x ==  1'b1;
assign system_call_exception = (   (scall_x ==  1'b1)
                                && (valid_x ==  1'b1)
			       );
assign exception_x =           (system_call_exception ==  1'b1)
                            || (instruction_bus_error_exception ==  1'b1)
                            || (data_bus_error_exception ==  1'b1)
                            || (divide_by_zero_exception ==  1'b1)
                            || (   (interrupt_exception ==  1'b1)
 				&& (store_q_m ==  1'b0)
				&& (D_CYC_O ==  1'b0)
                               )
                            ;
always @(*)
begin
         if (data_bus_error_exception ==  1'b1)
        eid_x =  3'h4;
    else
         if (instruction_bus_error_exception ==  1'b1)
        eid_x =  3'h2;
    else
         if (divide_by_zero_exception ==  1'b1)
        eid_x =  3'h5;
    else
         if (   (interrupt_exception ==  1'b1)
            )
        eid_x =  3'h6;
    else
        eid_x =  3'h7;
end
assign stall_a = (stall_f ==  1'b1);
assign stall_f = (stall_d ==  1'b1);
assign stall_d =   (stall_x ==  1'b1) 
                || (   (interlock ==  1'b1)
                    && (kill_d ==  1'b0)
                   ) 
		|| (   (   (eret_d ==  1'b1)
			|| (scall_d ==  1'b1)
			|| (bus_error_d ==  1'b1)
		       )
		    && (   (load_q_x ==  1'b1)
			|| (load_q_m ==  1'b1)
			|| (store_q_x ==  1'b1)
			|| (store_q_m ==  1'b1)
			|| (D_CYC_O ==  1'b1)
		       )
                    && (kill_d ==  1'b0)
		   )
                || (   (csr_write_enable_d ==  1'b1)
                    && (load_q_x ==  1'b1)
                   )                      
                ;
assign stall_x =    (stall_m ==  1'b1)
                 || (   (mc_stall_request_x ==  1'b1)
                     && (kill_x ==  1'b0)
                    ) 
                 ;
assign stall_m =    (stall_wb_load ==  1'b1)
                 || (   (D_CYC_O ==  1'b1)
                     && (   (store_m ==  1'b1)
		         || ((store_x ==  1'b1) && (interrupt_exception ==  1'b1))
                         || (load_m ==  1'b1)
                         || (load_x ==  1'b1)
                        ) 
                    ) 
                 || (dcache_stall_request ==  1'b1)     
                 || (icache_stall_request ==  1'b1)     
                 || ((I_CYC_O ==  1'b1) && ((branch_m ==  1'b1) || (exception_m ==  1'b1))) 
                 ;      
assign q_d = (valid_d ==  1'b1) && (kill_d ==  1'b0);
assign divide_q_d = (divide_d ==  1'b1) && (q_d ==  1'b1);
assign modulus_q_d = (modulus_d ==  1'b1) && (q_d ==  1'b1);
assign q_x = (valid_x ==  1'b1) && (kill_x ==  1'b0);
assign csr_write_enable_q_x = (csr_write_enable_x ==  1'b1) && (q_x ==  1'b1);
assign eret_q_x = (eret_x ==  1'b1) && (q_x ==  1'b1);
assign load_q_x = (load_x ==  1'b1) 
               && (q_x ==  1'b1)
                  ;
assign store_q_x = (store_x ==  1'b1) 
               && (q_x ==  1'b1)
                  ;
assign q_m = (valid_m ==  1'b1) && (kill_m ==  1'b0) && (exception_m ==  1'b0);
assign load_q_m = (load_m ==  1'b1) && (q_m ==  1'b1);
assign store_q_m = (store_m ==  1'b1) && (q_m ==  1'b1);
assign exception_q_w = ((exception_w ==  1'b1) && (valid_w ==  1'b1));        
assign write_enable_q_x = (write_enable_x ==  1'b1) && (valid_x ==  1'b1) && (branch_flushX_m ==  1'b0);
assign write_enable_q_m = (write_enable_m ==  1'b1) && (valid_m ==  1'b1);
assign write_enable_q_w = (write_enable_w ==  1'b1) && (valid_w ==  1'b1);
assign reg_write_enable_q_w = (write_enable_w ==  1'b1) && (kill_w ==  1'b0) && (valid_w ==  1'b1);
assign cfg = {
               6'h02,
              watchpoints[3:0],
              breakpoints[3:0],
              interrupts[5:0],
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b1,
               1'b1,
               1'b0,
               1'b0,
               1'b1,
               1'b1,
               1'b1,
               1'b1
              };
assign cfg2 = {
		     30'b0,
		      1'b0,
		      1'b0
		     };
assign iflush = (   (csr_write_enable_d ==  1'b1) 
                 && (csr_d ==  4 'h3)
                 && (stall_d ==  1'b0)
                 && (kill_d ==  1'b0)
                 && (valid_d ==  1'b1))
		 ;
assign dflush_x = (   (csr_write_enable_q_x ==  1'b1) 
                   && (csr_x ==  4 'h4))
		   ;
assign csr_d = read_idx_0_d[ (4 -1):0];
always @(*)
begin
    case (csr_x)
     4 'h0,
     4 'h1,
     4 'h2:   csr_read_data_x = interrupt_csr_read_data_x;  
     4 'h6:  csr_read_data_x = cfg;
     4 'h7:  csr_read_data_x = {eba, 8'h00};
     4 'ha: csr_read_data_x = cfg2;
     4 'hb:  csr_read_data_x = sdb_address;
    default:        csr_read_data_x = { 32{1'bx}};
    endcase
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        eba <= eba_reset[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    else
    begin
        if ((csr_write_enable_q_x ==  1'b1) && (csr_x ==  4 'h7) && (stall_x ==  1'b0))
            eba <= operand_1_x[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        data_bus_error_seen <=  1'b0;
    else
    begin
        if ((D_ERR_I ==  1'b1) && (D_CYC_O ==  1'b1))
            data_bus_error_seen <=  1'b1;
        if ((exception_m ==  1'b1) && (kill_m ==  1'b0))
            data_bus_error_seen <=  1'b0;
    end
end
always @(*)
begin
    if (   (icache_refill_request ==  1'b1) 
        || (dcache_refill_request ==  1'b1)
       )
        valid_a =  1'b0;
    else if (   (icache_restart_request ==  1'b1) 
             || (dcache_restart_request ==  1'b1) 
            ) 
        valid_a =  1'b1;
    else 
        valid_a = !icache_refilling && !dcache_refilling;
end 
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        valid_f <=  1'b0;
        valid_d <=  1'b0;
        valid_x <=  1'b0;
        valid_m <=  1'b0;
        valid_w <=  1'b0;
    end
    else
    begin    
        if ((kill_f ==  1'b1) || (stall_a ==  1'b0))
            valid_f <= valid_a;    
        else if (stall_f ==  1'b0)
            valid_f <=  1'b0;            
        if (kill_d ==  1'b1)
            valid_d <=  1'b0;
        else if (stall_f ==  1'b0)
            valid_d <= valid_f & !kill_f;
        else if (stall_d ==  1'b0)
            valid_d <=  1'b0;
        if (stall_d ==  1'b0)
            valid_x <= valid_d & !kill_d;
        else if (kill_x ==  1'b1)
            valid_x <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_x <=  1'b0;
        if (kill_m ==  1'b1)
            valid_m <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_m <= valid_x & !kill_x;
        else if (stall_m ==  1'b0)
            valid_m <=  1'b0;
        if (stall_m ==  1'b0)
            valid_w <= valid_m & !kill_m;
        else 
            valid_w <=  1'b0;        
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        operand_0_x <= { 32{1'b0}};
        operand_1_x <= { 32{1'b0}};
        store_operand_x <= { 32{1'b0}};
        branch_target_x <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};        
        x_result_sel_csr_x <=  1'b0;
        x_result_sel_mc_arith_x <=  1'b0;
        x_result_sel_sext_x <=  1'b0;
        x_result_sel_add_x <=  1'b0;
        m_result_sel_compare_x <=  1'b0;
        m_result_sel_shift_x <=  1'b0;
        w_result_sel_load_x <=  1'b0;
        w_result_sel_mul_x <=  1'b0;
        x_bypass_enable_x <=  1'b0;
        m_bypass_enable_x <=  1'b0;
        write_enable_x <=  1'b0;
        write_idx_x <= { 5{1'b0}};
        csr_x <= { 4 {1'b0}};
        load_x <=  1'b0;
        store_x <=  1'b0;
        size_x <= { 2{1'b0}};
        sign_extend_x <=  1'b0;
        adder_op_x <=  1'b0;
        adder_op_x_n <=  1'b0;
        logic_op_x <= 4'h0;
        direction_x <=  1'b0;
        branch_x <=  1'b0;
        branch_predict_x <=  1'b0;
        branch_predict_taken_x <=  1'b0;
        condition_x <=  3'b000;
        scall_x <=  1'b0;
        eret_x <=  1'b0;
        bus_error_x <=  1'b0;
        data_bus_error_exception_m <=  1'b0;
        csr_write_enable_x <=  1'b0;
        operand_m <= { 32{1'b0}};
        branch_target_m <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        m_result_sel_compare_m <=  1'b0;
        m_result_sel_shift_m <=  1'b0;
        w_result_sel_load_m <=  1'b0;
        w_result_sel_mul_m <=  1'b0;
        m_bypass_enable_m <=  1'b0;
        branch_m <=  1'b0;
        branch_predict_m <=  1'b0;
	branch_predict_taken_m <=  1'b0;
        exception_m <=  1'b0;
        load_m <=  1'b0;
        store_m <=  1'b0;
        write_enable_m <=  1'b0;            
        write_idx_m <= { 5{1'b0}};
        condition_met_m <=  1'b0;
        dflush_m <=  1'b0;
        operand_w <= { 32{1'b0}};        
        w_result_sel_load_w <=  1'b0;
        w_result_sel_mul_w <=  1'b0;
        write_idx_w <= { 5{1'b0}};        
        write_enable_w <=  1'b0;
        exception_w <=  1'b0;
        memop_pc_w <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
    end
    else
    begin
        if (stall_x ==  1'b0)
        begin
            operand_0_x <= d_result_0;
            operand_1_x <= d_result_1;
            store_operand_x <= bypass_data_1;
            branch_target_x <= branch_reg_d ==  1'b1 ? bypass_data_0[ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] : branch_target_d;            
            x_result_sel_csr_x <= x_result_sel_csr_d;
            x_result_sel_mc_arith_x <= x_result_sel_mc_arith_d;
            x_result_sel_sext_x <= x_result_sel_sext_d;
            x_result_sel_add_x <= x_result_sel_add_d;
            m_result_sel_compare_x <= m_result_sel_compare_d;
            m_result_sel_shift_x <= m_result_sel_shift_d;
            w_result_sel_load_x <= w_result_sel_load_d;
            w_result_sel_mul_x <= w_result_sel_mul_d;
            x_bypass_enable_x <= x_bypass_enable_d;
            m_bypass_enable_x <= m_bypass_enable_d;
            load_x <= load_d;
            store_x <= store_d;
            branch_x <= branch_d;
	    branch_predict_x <= branch_predict_d;
	    branch_predict_taken_x <= branch_predict_taken_d;
	    write_idx_x <= write_idx_d;
            csr_x <= csr_d;
            size_x <= size_d;
            sign_extend_x <= sign_extend_d;
            adder_op_x <= adder_op_d;
            adder_op_x_n <= ~adder_op_d;
            logic_op_x <= logic_op_d;
            direction_x <= direction_d;
            condition_x <= condition_d;
            csr_write_enable_x <= csr_write_enable_d;
            scall_x <= scall_d;
            bus_error_x <= bus_error_d;
            eret_x <= eret_d;
            write_enable_x <= write_enable_d;
        end
        if (stall_m ==  1'b0)
        begin
            operand_m <= x_result;
            m_result_sel_compare_m <= m_result_sel_compare_x;
            m_result_sel_shift_m <= m_result_sel_shift_x;
            if (exception_x ==  1'b1)
            begin
                w_result_sel_load_m <=  1'b0;
                w_result_sel_mul_m <=  1'b0;
            end
            else
            begin
                w_result_sel_load_m <= w_result_sel_load_x;
                w_result_sel_mul_m <= w_result_sel_mul_x;
            end
            m_bypass_enable_m <= m_bypass_enable_x;
            load_m <= load_x;
            store_m <= store_x;
            branch_m <= branch_x && !branch_taken_x;
            if (exception_x ==  1'b1)
                write_idx_m <=  5'd30;
            else 
                write_idx_m <= write_idx_x;
            condition_met_m <= condition_met_x;
            branch_target_m <= exception_x ==  1'b1 ? {eba, eid_x, {3{1'b0}}} : branch_target_x;
            dflush_m <= dflush_x;
            write_enable_m <= exception_x ==  1'b1 ?  1'b1 : write_enable_x;            
        end
        if (stall_m ==  1'b0)
        begin
            if ((exception_x ==  1'b1) && (q_x ==  1'b1) && (stall_x ==  1'b0))
                exception_m <=  1'b1;
            else 
                exception_m <=  1'b0;
	   data_bus_error_exception_m <=    (data_bus_error_exception ==  1'b1) 
					 ;
	end
        operand_w <= exception_m ==  1'b1 ? (data_bus_error_exception_m ? {memop_pc_w, 2'b00} : {pc_m, 2'b00}) : m_result;
        w_result_sel_load_w <= w_result_sel_load_m;
        w_result_sel_mul_w <= w_result_sel_mul_m;
        write_idx_w <= write_idx_m;
        write_enable_w <= write_enable_m;
        exception_w <= exception_m;
        if (   (stall_m ==  1'b0)
            && (   (load_q_m ==  1'b1) 
                || (store_q_m ==  1'b1)
               )
	   )
          memop_pc_w <= pc_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        use_buf <=  1'b0;
        reg_data_buf_0 <= { 32{1'b0}};
        reg_data_buf_1 <= { 32{1'b0}};
    end
    else
    begin
        if (stall_d ==  1'b0)
            use_buf <=  1'b0;
        else if (use_buf ==  1'b0)
        begin        
            reg_data_buf_0 <= reg_data_live_0;
            reg_data_buf_1 <= reg_data_live_1;
            use_buf <=  1'b1;
        end        
        if (reg_write_enable_q_w ==  1'b1)
        begin
            if (write_idx_w == read_idx_0_d)
                reg_data_buf_0 <= w_result;
            if (write_idx_w == read_idx_1_d)
                reg_data_buf_1 <= w_result;
        end
    end
end
initial
begin
end
endmodule 
module lm32_load_store_unit_full (
    clk_i,
    rst_i,
    stall_a,
    stall_x,
    stall_m,
    kill_x,
    kill_m,
    exception_m,
    store_operand_x,
    load_store_address_x,
    load_store_address_m,
    load_store_address_w,
    load_x,
    store_x,
    load_q_x,
    store_q_x,
    load_q_m,
    store_q_m,
    sign_extend_x,
    size_x,
    dflush,
    d_dat_i,
    d_ack_i,
    d_err_i,
    d_rty_i,
    dcache_refill_request,
    dcache_restart_request,
    dcache_stall_request,
    dcache_refilling,
    load_data_w,
    stall_wb_load,
    d_dat_o,
    d_adr_o,
    d_cyc_o,
    d_sel_o,
    d_stb_o,
    d_we_o,
    d_cti_o,
    d_lock_o,
    d_bte_o
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_x;                                          
input stall_m;                                          
input kill_x;                                           
input kill_m;                                           
input exception_m;                                      
input [ (32-1):0] store_operand_x;                 
input [ (32-1):0] load_store_address_x;            
input [ (32-1):0] load_store_address_m;            
input [1:0] load_store_address_w;                       
input load_x;                                           
input store_x;                                          
input load_q_x;                                         
input store_q_x;                                        
input load_q_m;                                         
input store_q_m;                                        
input sign_extend_x;                                    
input [ 1:0] size_x;                          
input dflush;                                           
input [ (32-1):0] d_dat_i;                         
input d_ack_i;                                          
input d_err_i;                                          
input d_rty_i;                                          
output dcache_refill_request;                           
wire   dcache_refill_request;
output dcache_restart_request;                          
wire   dcache_restart_request;
output dcache_stall_request;                            
wire   dcache_stall_request;
output dcache_refilling;
wire   dcache_refilling;
output [ (32-1):0] load_data_w;                    
reg    [ (32-1):0] load_data_w;
output stall_wb_load;                                   
reg    stall_wb_load;
output [ (32-1):0] d_dat_o;                        
reg    [ (32-1):0] d_dat_o;
output [ (32-1):0] d_adr_o;                        
reg    [ (32-1):0] d_adr_o;
output d_cyc_o;                                         
reg    d_cyc_o;
output [ (4-1):0] d_sel_o;                 
reg    [ (4-1):0] d_sel_o;
output d_stb_o;                                         
reg    d_stb_o; 
output d_we_o;                                          
reg    d_we_o;
output [ (3-1):0] d_cti_o;                       
reg    [ (3-1):0] d_cti_o;
output d_lock_o;                                        
reg    d_lock_o;
output [ (2-1):0] d_bte_o;                       
wire   [ (2-1):0] d_bte_o;
reg [ 1:0] size_m;
reg [ 1:0] size_w;
reg sign_extend_m;
reg sign_extend_w;
reg [ (32-1):0] store_data_x;       
reg [ (32-1):0] store_data_m;       
reg [ (4-1):0] byte_enable_x;
reg [ (4-1):0] byte_enable_m;
wire [ (32-1):0] data_m;
reg [ (32-1):0] data_w;
wire dcache_select_x;                                   
reg dcache_select_m;
wire [ (32-1):0] dcache_data_m;                    
wire [ (32-1):0] dcache_refill_address;            
reg dcache_refill_ready;                                
wire [ (3-1):0] first_cycle_type;                
wire [ (3-1):0] next_cycle_type;                 
wire last_word;                                         
wire [ (32-1):0] first_address;                    
wire wb_select_x;                                       
reg wb_select_m;
reg [ (32-1):0] wb_data_m;                         
reg wb_load_complete;                                   
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_dcache_full #(
    .associativity          (associativity),
    .sets                   (sets),
    .bytes_per_line         (bytes_per_line),
    .base_address           (base_address),
    .limit                  (limit)
    ) dcache ( 
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),      
    .stall_a                (stall_a),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .address_x              (load_store_address_x),
    .address_m              (load_store_address_m),
    .load_q_m               (load_q_m & dcache_select_m),
    .store_q_m              (store_q_m & dcache_select_m),
    .store_data             (store_data_m),
    .store_byte_select      (byte_enable_m & {4{dcache_select_m}}),
    .refill_ready           (dcache_refill_ready),
    .refill_data            (wb_data_m),
    .dflush                 (dflush),
    .stall_request          (dcache_stall_request),
    .restart_request        (dcache_restart_request),
    .refill_request         (dcache_refill_request),
    .refill_address         (dcache_refill_address),
    .refilling              (dcache_refilling),
    .load_data              (dcache_data_m)
    );
   assign dcache_select_x =    (load_store_address_x >=  32'h0) 
                            && (load_store_address_x <=  32'h7fffffff)
                     ;
   assign wb_select_x =     1'b1
                        && !dcache_select_x 
                     ;
always @(*)
begin
    case (size_x)
     2'b00:  store_data_x = {4{store_operand_x[7:0]}};
     2'b11: store_data_x = {2{store_operand_x[15:0]}};
     2'b10:  store_data_x = store_operand_x;    
    default:          store_data_x = { 32{1'bx}};
    endcase
end
always @(*)
begin
    casez ({size_x, load_store_address_x[1:0]})
    { 2'b00, 2'b11}:  byte_enable_x = 4'b0001;
    { 2'b00, 2'b10}:  byte_enable_x = 4'b0010;
    { 2'b00, 2'b01}:  byte_enable_x = 4'b0100;
    { 2'b00, 2'b00}:  byte_enable_x = 4'b1000;
    { 2'b11, 2'b1?}: byte_enable_x = 4'b0011;
    { 2'b11, 2'b0?}: byte_enable_x = 4'b1100;
    { 2'b10, 2'b??}:  byte_enable_x = 4'b1111;
    default:                   byte_enable_x = 4'bxxxx;
    endcase
end
   assign data_m = wb_select_m ==  1'b1 
                   ? wb_data_m 
                   : dcache_data_m;
always @(*)
begin
    casez ({size_w, load_store_address_w[1:0]})
    { 2'b00, 2'b11}:  load_data_w = {{24{sign_extend_w & data_w[7]}}, data_w[7:0]};
    { 2'b00, 2'b10}:  load_data_w = {{24{sign_extend_w & data_w[15]}}, data_w[15:8]};
    { 2'b00, 2'b01}:  load_data_w = {{24{sign_extend_w & data_w[23]}}, data_w[23:16]};
    { 2'b00, 2'b00}:  load_data_w = {{24{sign_extend_w & data_w[31]}}, data_w[31:24]};
    { 2'b11, 2'b1?}: load_data_w = {{16{sign_extend_w & data_w[15]}}, data_w[15:0]};
    { 2'b11, 2'b0?}: load_data_w = {{16{sign_extend_w & data_w[31]}}, data_w[31:16]};
    { 2'b10, 2'b??}:  load_data_w = data_w;
    default:                   load_data_w = { 32{1'bx}};
    endcase
end
assign d_bte_o =  2'b00;
generate 
    case (bytes_per_line)
    4:
    begin
assign first_cycle_type =  3'b111;
assign next_cycle_type =  3'b111;
assign last_word =  1'b1;
assign first_address = {dcache_refill_address[ 32-1:2], 2'b00};
    end
    8:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type =  3'b111;
assign last_word = (&d_adr_o[addr_offset_msb:addr_offset_lsb]) == 1'b1;
assign first_address = {dcache_refill_address[ 32-1:addr_offset_msb+1], {addr_offset_width{1'b0}}, 2'b00};
    end
    16:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type = d_adr_o[addr_offset_msb] == 1'b1 ?  3'b111 :  3'b010;
assign last_word = (&d_adr_o[addr_offset_msb:addr_offset_lsb]) == 1'b1;
assign first_address = {dcache_refill_address[ 32-1:addr_offset_msb+1], {addr_offset_width{1'b0}}, 2'b00};
    end
    endcase
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        d_cyc_o <=  1'b0;
        d_stb_o <=  1'b0;
        d_dat_o <= { 32{1'b0}};
        d_adr_o <= { 32{1'b0}};
        d_sel_o <= { 4{ 1'b0}};
        d_we_o <=  1'b0;
        d_cti_o <=  3'b111;
        d_lock_o <=  1'b0;
        wb_data_m <= { 32{1'b0}};
        wb_load_complete <=  1'b0;
        stall_wb_load <=  1'b0;
        dcache_refill_ready <=  1'b0;
    end
    else
    begin
        dcache_refill_ready <=  1'b0;
        if (d_cyc_o ==  1'b1)
        begin
            if ((d_ack_i ==  1'b1) || (d_err_i ==  1'b1))
            begin
                if ((dcache_refilling ==  1'b1) && (!last_word))
                begin
                    d_adr_o[addr_offset_msb:addr_offset_lsb] <= d_adr_o[addr_offset_msb:addr_offset_lsb] + 1'b1;
                end
                else
                begin
                    d_cyc_o <=  1'b0;
                    d_stb_o <=  1'b0;
                    d_lock_o <=  1'b0;
                end
                d_cti_o <= next_cycle_type;
                dcache_refill_ready <= dcache_refilling;
                wb_data_m <= d_dat_i;
                wb_load_complete <= !d_we_o;
            end
            if (d_err_i ==  1'b1)
                $display ("Data bus error. Address: %x", d_adr_o);
        end
        else
        begin
            if (dcache_refill_request ==  1'b1)
            begin
                d_adr_o <= first_address;
                d_cyc_o <=  1'b1;
                d_sel_o <= { 32/8{ 1'b1}};
                d_stb_o <=  1'b1;                
                d_we_o <=  1'b0;
                d_cti_o <= first_cycle_type;
            end
            else 
                 if (   (store_q_m ==  1'b1)
                     && (stall_m ==  1'b0)
                    )
            begin
                d_dat_o <= store_data_m;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b1;
                d_cti_o <=  3'b111;
            end        
            else if (   (load_q_m ==  1'b1) 
                     && (wb_select_m ==  1'b1) 
                     && (wb_load_complete ==  1'b0)
                    )
            begin
                stall_wb_load <=  1'b0;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b0;
                d_cti_o <=  3'b111;
            end
        end
        if (stall_m ==  1'b0)
            wb_load_complete <=  1'b0;
        if ((load_q_x ==  1'b1) && (wb_select_x ==  1'b1) && (stall_x ==  1'b0))
            stall_wb_load <=  1'b1;
        if ((kill_m ==  1'b1) || (exception_m ==  1'b1))
            stall_wb_load <=  1'b0;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        sign_extend_m <=  1'b0;
        size_m <= 2'b00;
        byte_enable_m <=  1'b0;
        store_data_m <= { 32{1'b0}};
        dcache_select_m <=  1'b0;
        wb_select_m <=  1'b0;        
    end
    else
    begin
        if (stall_m ==  1'b0)
        begin
            sign_extend_m <= sign_extend_x;
            size_m <= size_x;
            byte_enable_m <= byte_enable_x;    
            store_data_m <= store_data_x;
            dcache_select_m <= dcache_select_x;
            wb_select_m <= wb_select_x;
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        size_w <= 2'b00;
        data_w <= { 32{1'b0}};
        sign_extend_w <=  1'b0;
    end
    else
    begin
        size_w <= size_m;
        data_w <= data_m;
        sign_extend_w <= sign_extend_m;
    end
end
always @(posedge clk_i)
begin
    if (((load_q_m ==  1'b1) || (store_q_m ==  1'b1)) && (stall_m ==  1'b0)) 
    begin
        if ((size_m ===  2'b11) && (load_store_address_m[0] !== 1'b0))
            $display ("Warning: Non-aligned halfword access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
        if ((size_m ===  2'b10) && (load_store_address_m[1:0] !== 2'b00))
            $display ("Warning: Non-aligned word access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
    end
end
endmodule
module lm32_decoder_full (
    instruction,
    d_result_sel_0,
    d_result_sel_1,        
    x_result_sel_csr,
    x_result_sel_mc_arith,
    x_result_sel_sext,
    x_result_sel_logic,
    x_result_sel_add,
    m_result_sel_compare,
    m_result_sel_shift,  
    w_result_sel_load,
    w_result_sel_mul,
    x_bypass_enable,
    m_bypass_enable,
    read_enable_0,
    read_idx_0,
    read_enable_1,
    read_idx_1,
    write_enable,
    write_idx,
    immediate,
    branch_offset,
    load,
    store,
    size,
    sign_extend,
    adder_op,
    logic_op,
    direction,
    divide,
    modulus,
    branch,
    branch_reg,
    condition,
    bi_conditional,
    bi_unconditional,
    scall,
    eret,
    csr_write_enable
    );
input [ (32-1):0] instruction;       
output [ 0:0] d_result_sel_0;
reg    [ 0:0] d_result_sel_0;
output [ 1:0] d_result_sel_1;
reg    [ 1:0] d_result_sel_1;
output x_result_sel_csr;
reg    x_result_sel_csr;
output x_result_sel_mc_arith;
reg    x_result_sel_mc_arith;
output x_result_sel_sext;
reg    x_result_sel_sext;
output x_result_sel_logic;
reg    x_result_sel_logic;
output x_result_sel_add;
reg    x_result_sel_add;
output m_result_sel_compare;
reg    m_result_sel_compare;
output m_result_sel_shift;
reg    m_result_sel_shift;
output w_result_sel_load;
reg    w_result_sel_load;
output w_result_sel_mul;
reg    w_result_sel_mul;
output x_bypass_enable;
wire   x_bypass_enable;
output m_bypass_enable;
wire   m_bypass_enable;
output read_enable_0;
wire   read_enable_0;
output [ (5-1):0] read_idx_0;
wire   [ (5-1):0] read_idx_0;
output read_enable_1;
wire   read_enable_1;
output [ (5-1):0] read_idx_1;
wire   [ (5-1):0] read_idx_1;
output write_enable;
wire   write_enable;
output [ (5-1):0] write_idx;
wire   [ (5-1):0] write_idx;
output [ (32-1):0] immediate;
wire   [ (32-1):0] immediate;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset;
wire   [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset;
output load;
wire   load;
output store;
wire   store;
output [ 1:0] size;
wire   [ 1:0] size;
output sign_extend;
wire   sign_extend;
output adder_op;
wire   adder_op;
output [ 3:0] logic_op;
wire   [ 3:0] logic_op;
output direction;
wire   direction;
output divide;
wire   divide;
output modulus;
wire   modulus;
output branch;
wire   branch;
output branch_reg;
wire   branch_reg;
output [ (3-1):0] condition;
wire   [ (3-1):0] condition;
output bi_conditional;
wire bi_conditional;
output bi_unconditional;
wire bi_unconditional;
output scall;
wire   scall;
output eret;
wire   eret;
output csr_write_enable;
wire   csr_write_enable;
wire [ (32-1):0] extended_immediate;       
wire [ (32-1):0] high_immediate;           
wire [ (32-1):0] call_immediate;           
wire [ (32-1):0] branch_immediate;         
wire sign_extend_immediate;                     
wire select_high_immediate;                     
wire select_call_immediate;                     
wire op_add;
wire op_and;
wire op_andhi;
wire op_b;
wire op_bi;
wire op_be;
wire op_bg;
wire op_bge;
wire op_bgeu;
wire op_bgu;
wire op_bne;
wire op_call;
wire op_calli;
wire op_cmpe;
wire op_cmpg;
wire op_cmpge;
wire op_cmpgeu;
wire op_cmpgu;
wire op_cmpne;
wire op_divu;
wire op_lb;
wire op_lbu;
wire op_lh;
wire op_lhu;
wire op_lw;
wire op_modu;
wire op_mul;
wire op_nor;
wire op_or;
wire op_orhi;
wire op_raise;
wire op_rcsr;
wire op_sb;
wire op_sextb;
wire op_sexth;
wire op_sh;
wire op_sl;
wire op_sr;
wire op_sru;
wire op_sub;
wire op_sw;
wire op_wcsr;
wire op_xnor;
wire op_xor;
wire arith;
wire logical;
wire cmp;
wire bra;
wire call;
wire shift;
wire sext;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
assign op_add    = instruction[ 30:26] ==  5'b01101;
assign op_and    = instruction[ 30:26] ==  5'b01000;
assign op_andhi  = instruction[ 31:26] ==  6'b011000;
assign op_b      = instruction[ 31:26] ==  6'b110000;
assign op_bi     = instruction[ 31:26] ==  6'b111000;
assign op_be     = instruction[ 31:26] ==  6'b010001;
assign op_bg     = instruction[ 31:26] ==  6'b010010;
assign op_bge    = instruction[ 31:26] ==  6'b010011;
assign op_bgeu   = instruction[ 31:26] ==  6'b010100;
assign op_bgu    = instruction[ 31:26] ==  6'b010101;
assign op_bne    = instruction[ 31:26] ==  6'b010111;
assign op_call   = instruction[ 31:26] ==  6'b110110;
assign op_calli  = instruction[ 31:26] ==  6'b111110;
assign op_cmpe   = instruction[ 30:26] ==  5'b11001;
assign op_cmpg   = instruction[ 30:26] ==  5'b11010;
assign op_cmpge  = instruction[ 30:26] ==  5'b11011;
assign op_cmpgeu = instruction[ 30:26] ==  5'b11100;
assign op_cmpgu  = instruction[ 30:26] ==  5'b11101;
assign op_cmpne  = instruction[ 30:26] ==  5'b11111;
assign op_divu   = instruction[ 31:26] ==  6'b100011;
assign op_lb     = instruction[ 31:26] ==  6'b000100;
assign op_lbu    = instruction[ 31:26] ==  6'b010000;
assign op_lh     = instruction[ 31:26] ==  6'b000111;
assign op_lhu    = instruction[ 31:26] ==  6'b001011;
assign op_lw     = instruction[ 31:26] ==  6'b001010;
assign op_modu   = instruction[ 31:26] ==  6'b110001;
assign op_mul    = instruction[ 30:26] ==  5'b00010;
assign op_nor    = instruction[ 30:26] ==  5'b00001;
assign op_or     = instruction[ 30:26] ==  5'b01110;
assign op_orhi   = instruction[ 31:26] ==  6'b011110;
assign op_raise  = instruction[ 31:26] ==  6'b101011;
assign op_rcsr   = instruction[ 31:26] ==  6'b100100;
assign op_sb     = instruction[ 31:26] ==  6'b001100;
assign op_sextb  = instruction[ 31:26] ==  6'b101100;
assign op_sexth  = instruction[ 31:26] ==  6'b110111;
assign op_sh     = instruction[ 31:26] ==  6'b000011;
assign op_sl     = instruction[ 30:26] ==  5'b01111;      
assign op_sr     = instruction[ 30:26] ==  5'b00101;
assign op_sru    = instruction[ 30:26] ==  5'b00000;
assign op_sub    = instruction[ 31:26] ==  6'b110010;
assign op_sw     = instruction[ 31:26] ==  6'b010110;
assign op_wcsr   = instruction[ 31:26] ==  6'b110100;
assign op_xnor   = instruction[ 30:26] ==  5'b01001;
assign op_xor    = instruction[ 30:26] ==  5'b00110;
assign arith = op_add | op_sub;
assign logical = op_and | op_andhi | op_nor | op_or | op_orhi | op_xor | op_xnor;
assign cmp = op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne;
assign bi_conditional = op_be | op_bg | op_bge | op_bgeu  | op_bgu | op_bne;
assign bi_unconditional = op_bi;
assign bra = op_b | bi_unconditional | bi_conditional;
assign call = op_call | op_calli;
assign shift = op_sl | op_sr | op_sru;
assign sext = op_sextb | op_sexth;
assign divide = op_divu; 
assign modulus = op_modu;
assign load = op_lb | op_lbu | op_lh | op_lhu | op_lw;
assign store = op_sb | op_sh | op_sw;
always @(*)
begin
    if (call) 
        d_result_sel_0 =  1'b1;
    else 
        d_result_sel_0 =  1'b0;
    if (call) 
        d_result_sel_1 =  2'b00;         
    else if ((instruction[31] == 1'b0) && !bra) 
        d_result_sel_1 =  2'b10;
    else
        d_result_sel_1 =  2'b01; 
    x_result_sel_csr =  1'b0;
    x_result_sel_mc_arith =  1'b0;
    x_result_sel_sext =  1'b0;
    x_result_sel_logic =  1'b0;
    x_result_sel_add =  1'b0;
    if (op_rcsr)
        x_result_sel_csr =  1'b1;
    else if (divide | modulus)
        x_result_sel_mc_arith =  1'b1;        
    else if (sext)
        x_result_sel_sext =  1'b1;
    else if (logical) 
        x_result_sel_logic =  1'b1;
    else 
        x_result_sel_add =  1'b1;        
    m_result_sel_compare = cmp;
    m_result_sel_shift = shift;
    w_result_sel_load = load;
    w_result_sel_mul = op_mul; 
end
assign x_bypass_enable =  arith 
                        | logical
                        | divide
                        | modulus
                        | sext 
                        | op_rcsr
                        ;
assign m_bypass_enable = x_bypass_enable 
                        | shift
                        | cmp
                        ;
assign read_enable_0 = ~(op_bi | op_calli);
assign read_idx_0 = instruction[25:21];
assign read_enable_1 = ~(op_bi | op_calli | load);
assign read_idx_1 = instruction[20:16];
assign write_enable = ~(bra | op_raise | store | op_wcsr);
assign write_idx = call
                    ? 5'd29
                    : instruction[31] == 1'b0 
                        ? instruction[20:16] 
                        : instruction[15:11];
assign size = instruction[27:26];
assign sign_extend = instruction[28];                      
assign adder_op = op_sub | op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne | bra;
assign logic_op = instruction[29:26];
assign direction = instruction[29];
assign branch = bra | call;
assign branch_reg = op_call | op_b;
assign condition = instruction[28:26];      
assign scall = op_raise & instruction[2];
assign eret = op_b & (instruction[25:21] == 5'd30);
assign csr_write_enable = op_wcsr;
assign sign_extend_immediate = ~(op_and | op_cmpgeu | op_cmpgu | op_nor | op_or | op_xnor | op_xor);
assign select_high_immediate = op_andhi | op_orhi;
assign select_call_immediate = instruction[31];
assign high_immediate = {instruction[15:0], 16'h0000};
assign extended_immediate = {{16{sign_extend_immediate & instruction[15]}}, instruction[15:0]};
assign call_immediate = {{6{instruction[25]}}, instruction[25:0]};
assign branch_immediate = {{16{instruction[15]}}, instruction[15:0]};
assign immediate = select_high_immediate ==  1'b1 
                        ? high_immediate 
                        : extended_immediate;
assign branch_offset = select_call_immediate ==  1'b1   
                        ? (call_immediate[ (clogb2(32'h7fffffff-32'h0)-2)-1:0])
                        : (branch_immediate[ (clogb2(32'h7fffffff-32'h0)-2)-1:0]);
endmodule 
module lm32_icache_full ( 
    clk_i,
    rst_i,    
    stall_a,
    stall_f,
    address_a,
    address_f,
    read_enable_f,
    refill_ready,
    refill_data,
    iflush,
    valid_d,
    branch_predict_taken_d,
    stall_request,
    restart_request,
    refill_request,
    refill_address,
    refilling,
    inst
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = clogb2(bytes_per_line)-1-2;
localparam addr_set_width = clogb2(sets)-1;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
localparam addr_set_lsb = (addr_offset_msb+1);
localparam addr_set_msb = (addr_set_lsb+addr_set_width-1);
localparam addr_tag_lsb = (addr_set_msb+1);
localparam addr_tag_msb = clogb2( 32'h7fffffff- 32'h0)-1;
localparam addr_tag_width = (addr_tag_msb-addr_tag_lsb+1);
input clk_i;                                        
input rst_i;                                        
input stall_a;                                      
input stall_f;                                      
input valid_d;                                      
input branch_predict_taken_d;                       
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] address_a;                     
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] address_f;                     
input read_enable_f;                                
input refill_ready;                                 
input [ (32-1):0] refill_data;          
input iflush;                                       
output stall_request;                               
wire   stall_request;
output restart_request;                             
reg    restart_request;
output refill_request;                              
wire   refill_request;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] refill_address;               
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] refill_address;               
output refilling;                                   
reg    refilling;
output [ (32-1):0] inst;                
wire   [ (32-1):0] inst;
wire enable;
wire [0:associativity-1] way_mem_we;
wire [ (32-1):0] way_data[0:associativity-1];
wire [ ((addr_tag_width+1)-1):1] way_tag[0:associativity-1];
wire [0:associativity-1] way_valid;
wire [0:associativity-1] way_match;
wire miss;
wire [ (addr_set_width-1):0] tmem_read_address;
wire [ (addr_set_width-1):0] tmem_write_address;
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_read_address;
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_write_address;
wire [ ((addr_tag_width+1)-1):0] tmem_write_data;
reg [ 3:0] state;
wire flushing;
wire check;
wire refill;
reg [associativity-1:0] refill_way_select;
reg [ addr_offset_msb:addr_offset_lsb] refill_offset;
wire last_refill;
reg [ (addr_set_width-1):0] flush_set;
genvar i;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
   generate
      for (i = 0; i < associativity; i = i + 1)
	begin : memories
	   lm32_ram 
	     #(
	       .data_width                 (32),
	       .address_width              ( (addr_offset_width+addr_set_width))
) 
	   way_0_data_ram 
	     (
	      .read_clk                   (clk_i),
	      .write_clk                  (clk_i),
	      .reset                      (rst_i),
	      .read_address               (dmem_read_address),
	      .enable_read                (enable),
	      .write_address              (dmem_write_address),
	      .enable_write               ( 1'b1),
	      .write_enable               (way_mem_we[i]),
	      .write_data                 (refill_data),    
	      .read_data                  (way_data[i])
	      );
	   lm32_ram 
	     #(
	       .data_width                 ( (addr_tag_width+1)),
	       .address_width              ( addr_set_width)
	       ) 
	   way_0_tag_ram 
	     (
	      .read_clk                   (clk_i),
	      .write_clk                  (clk_i),
	      .reset                      (rst_i),
	      .read_address               (tmem_read_address),
	      .enable_read                (enable),
	      .write_address              (tmem_write_address),
	      .enable_write               ( 1'b1),
	      .write_enable               (way_mem_we[i] | flushing),
	      .write_data                 (tmem_write_data),
	      .read_data                  ({way_tag[i], way_valid[i]})
	      );
	end
endgenerate
generate
    for (i = 0; i < associativity; i = i + 1)
    begin : match
assign way_match[i] = ({way_tag[i], way_valid[i]} == {address_f[ addr_tag_msb:addr_tag_lsb],  1'b1});
    end
endgenerate
generate
    if (associativity == 1)
    begin : inst_1
assign inst = way_match[0] ? way_data[0] : 32'b0;
    end
    else if (associativity == 2)
	 begin : inst_2
assign inst = way_match[0] ? way_data[0] : (way_match[1] ? way_data[1] : 32'b0);
    end
endgenerate
generate 
    if (bytes_per_line > 4)
assign dmem_write_address = {refill_address[ addr_set_msb:addr_set_lsb], refill_offset};
    else
assign dmem_write_address = refill_address[ addr_set_msb:addr_set_lsb];
endgenerate
assign dmem_read_address = address_a[ addr_set_msb:addr_offset_lsb];
assign tmem_read_address = address_a[ addr_set_msb:addr_set_lsb];
assign tmem_write_address = flushing 
                                ? flush_set
                                : refill_address[ addr_set_msb:addr_set_lsb];
generate 
    if (bytes_per_line > 4)                            
assign last_refill = refill_offset == {addr_offset_width{1'b1}};
    else
assign last_refill =  1'b1;
endgenerate
assign enable = (stall_a ==  1'b0);
generate
    if (associativity == 1) 
    begin : we_1     
assign way_mem_we[0] = (refill_ready ==  1'b1);
    end
    else
    begin : we_2
assign way_mem_we[0] = (refill_ready ==  1'b1) && (refill_way_select[0] ==  1'b1);
assign way_mem_we[1] = (refill_ready ==  1'b1) && (refill_way_select[1] ==  1'b1);
    end
endgenerate                     
assign tmem_write_data[ 0] = last_refill & !flushing;
assign tmem_write_data[ ((addr_tag_width+1)-1):1] = refill_address[ addr_tag_msb:addr_tag_lsb];
assign flushing = |state[1:0];
assign check = state[2];
assign refill = state[3];
assign miss = (~(|way_match)) && (read_enable_f ==  1'b1) && (stall_f ==  1'b0) && !(valid_d && branch_predict_taken_d);
assign stall_request = (check ==  1'b0);
assign refill_request = (refill ==  1'b1);
generate
    if (associativity >= 2) 
    begin : way_select      
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_way_select <= {{associativity-1{1'b0}}, 1'b1};
    else
    begin        
        if (miss ==  1'b1)
            refill_way_select <= {refill_way_select[0], refill_way_select[1]};
    end
end
    end
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refilling <=  1'b0;
    else
        refilling <= refill;
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        state <=  4'b0001;
        flush_set <= { addr_set_width{1'b1}};
        refill_address <= { (clogb2(32'h7fffffff-32'h0)-2){1'bx}};
        restart_request <=  1'b0;
    end
    else 
    begin
        case (state)
         4'b0001:
        begin            
            if (flush_set == { addr_set_width{1'b0}})
                state <=  4'b0100;
            flush_set <= flush_set - 1'b1;
        end
         4'b0010:
        begin            
            if (flush_set == { addr_set_width{1'b0}})
		state <=  4'b0100;
            flush_set <= flush_set - 1'b1;
        end
         4'b0100:
        begin            
            if (stall_a ==  1'b0)
                restart_request <=  1'b0;
            if (iflush ==  1'b1)
            begin
                refill_address <= address_f;
                state <=  4'b0010;
            end
            else if (miss ==  1'b1)
            begin
                refill_address <= address_f;
                state <=  4'b1000;
            end
        end
         4'b1000:
        begin            
            if (refill_ready ==  1'b1)
            begin
                if (last_refill ==  1'b1)
                begin
                    restart_request <=  1'b1;
                    state <=  4'b0100;
                end
            end
        end
        endcase        
    end
end
generate 
    if (bytes_per_line > 4)
    begin
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_offset <= {addr_offset_width{1'b0}};
    else 
    begin
        case (state)
         4'b0100:
        begin            
            if (iflush ==  1'b1)
                refill_offset <= {addr_offset_width{1'b0}};
            else if (miss ==  1'b1)
                refill_offset <= {addr_offset_width{1'b0}};
        end
         4'b1000:
        begin            
            if (refill_ready ==  1'b1)
                refill_offset <= refill_offset + 1'b1;
        end
        endcase        
    end
end
    end
endgenerate
endmodule
module lm32_dcache_full ( 
    clk_i,
    rst_i,    
    stall_a,
    stall_x,
    stall_m,
    address_x,
    address_m,
    load_q_m,
    store_q_m,
    store_data,
    store_byte_select,
    refill_ready,
    refill_data,
    dflush,
    stall_request,
    restart_request,
    refill_request,
    refill_address,
    refilling,
    load_data
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = clogb2(bytes_per_line)-1-2;
localparam addr_set_width = clogb2(sets)-1;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
localparam addr_set_lsb = (addr_offset_msb+1);
localparam addr_set_msb = (addr_set_lsb+addr_set_width-1);
localparam addr_tag_lsb = (addr_set_msb+1);
localparam addr_tag_msb = clogb2( 32'h7fffffff- 32'h0)-1;
localparam addr_tag_width = (addr_tag_msb-addr_tag_lsb+1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_x;                                          
input stall_m;                                          
input [ (32-1):0] address_x;                       
input [ (32-1):0] address_m;                       
input load_q_m;                                         
input store_q_m;                                        
input [ (32-1):0] store_data;                      
input [ (4-1):0] store_byte_select;        
input refill_ready;                                     
input [ (32-1):0] refill_data;                     
input dflush;                                           
output stall_request;                                   
wire   stall_request;
output restart_request;                                 
reg    restart_request;
output refill_request;                                  
reg    refill_request;
output [ (32-1):0] refill_address;                 
reg    [ (32-1):0] refill_address;
output refilling;                                       
reg    refilling;
output [ (32-1):0] load_data;                      
wire   [ (32-1):0] load_data;
wire read_port_enable;                                  
wire write_port_enable;                                 
wire [0:associativity-1] way_tmem_we;                   
wire [0:associativity-1] way_dmem_we;                   
wire [ (32-1):0] way_data[0:associativity-1];      
wire [ ((addr_tag_width+1)-1):1] way_tag[0:associativity-1];
wire [0:associativity-1] way_valid;                     
wire [0:associativity-1] way_match;                     
wire miss;                                              
wire [ (addr_set_width-1):0] tmem_read_address;        
wire [ (addr_set_width-1):0] tmem_write_address;       
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_read_address;        
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_write_address;       
wire [ ((addr_tag_width+1)-1):0] tmem_write_data;               
reg [ (32-1):0] dmem_write_data;                   
reg [ 2:0] state;                         
wire flushing;                                          
wire check;                                             
wire refill;                                            
wire valid_store;                                       
reg [associativity-1:0] refill_way_select;              
reg [ addr_offset_msb:addr_offset_lsb] refill_offset;           
wire last_refill;                                       
reg [ (addr_set_width-1):0] flush_set;                 
genvar i, j;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
   generate
      for (i = 0; i < associativity; i = i + 1)    
	begin : memories
           if ( (addr_offset_width+addr_set_width) < 11)
             begin : data_memories
		lm32_ram 
		  #(
		    .data_width (32),
		    .address_width ( (addr_offset_width+addr_set_width))
		    ) way_0_data_ram 
		    (
		     .read_clk (clk_i),
		     .write_clk (clk_i),
		     .reset (rst_i),
		     .read_address (dmem_read_address),
		     .enable_read (read_port_enable),
		     .write_address (dmem_write_address),
		     .enable_write (write_port_enable),
		     .write_enable (way_dmem_we[i]),
		     .write_data (dmem_write_data),    
		     .read_data (way_data[i])
		     );    
             end
           else
             begin
		for (j = 0; j < 4; j = j + 1)    
		  begin : byte_memories
		     lm32_ram 
		       #(
			 .data_width (8),
			 .address_width ( (addr_offset_width+addr_set_width))
			 ) way_0_data_ram 
			 (
			  .read_clk (clk_i),
			  .write_clk (clk_i),
			  .reset (rst_i),
			  .read_address (dmem_read_address),
			  .enable_read (read_port_enable),
			  .write_address (dmem_write_address),
			  .enable_write (write_port_enable),
			  .write_enable (way_dmem_we[i] & (store_byte_select[j] | refill)),
			  .write_data (dmem_write_data[(j+1)*8-1:j*8]),    
			  .read_data (way_data[i][(j+1)*8-1:j*8])
			  );
		  end
             end
	   lm32_ram 
	     #(
	       .data_width ( (addr_tag_width+1)),
	       .address_width ( addr_set_width)
	       ) way_0_tag_ram 
	       (
		.read_clk (clk_i),
		.write_clk (clk_i),
		.reset (rst_i),
		.read_address (tmem_read_address),
		.enable_read (read_port_enable),
		.write_address (tmem_write_address),
		.enable_write ( 1'b1),
		.write_enable (way_tmem_we[i]),
		.write_data (tmem_write_data),
		.read_data ({way_tag[i], way_valid[i]})
		);
	end
   endgenerate
generate
    for (i = 0; i < associativity; i = i + 1)
    begin : match
assign way_match[i] = ({way_tag[i], way_valid[i]} == {address_m[ addr_tag_msb:addr_tag_lsb],  1'b1});
    end
endgenerate
generate
    if (associativity == 1)    
	 begin : data_1
assign load_data = way_data[0];
    end
    else if (associativity == 2)
	 begin : data_2
assign load_data = way_match[0] ? way_data[0] : way_data[1]; 
    end
endgenerate
generate
    if ( (addr_offset_width+addr_set_width) < 11)
    begin
always @(*)
begin
    if (refill ==  1'b1)
        dmem_write_data = refill_data;
    else
    begin
        dmem_write_data[ 7:0] = store_byte_select[0] ? store_data[ 7:0] : load_data[ 7:0];
        dmem_write_data[ 15:8] = store_byte_select[1] ? store_data[ 15:8] : load_data[ 15:8];
        dmem_write_data[ 23:16] = store_byte_select[2] ? store_data[ 23:16] : load_data[ 23:16];
        dmem_write_data[ 31:24] = store_byte_select[3] ? store_data[ 31:24] : load_data[ 31:24];
    end
end
    end
    else
    begin
always @(*)
begin
    if (refill ==  1'b1)
        dmem_write_data = refill_data;
    else
        dmem_write_data = store_data;
end
    end
endgenerate
generate 
     if (bytes_per_line > 4)
assign dmem_write_address = (refill ==  1'b1) 
                            ? {refill_address[ addr_set_msb:addr_set_lsb], refill_offset}
                            : address_m[ addr_set_msb:addr_offset_lsb];
    else
assign dmem_write_address = (refill ==  1'b1) 
                            ? refill_address[ addr_set_msb:addr_set_lsb]
                            : address_m[ addr_set_msb:addr_offset_lsb];
endgenerate
assign dmem_read_address = address_x[ addr_set_msb:addr_offset_lsb];
assign tmem_write_address = (flushing ==  1'b1)
                            ? flush_set
                            : refill_address[ addr_set_msb:addr_set_lsb];
assign tmem_read_address = address_x[ addr_set_msb:addr_set_lsb];
generate 
    if (bytes_per_line > 4)                            
assign last_refill = refill_offset == {addr_offset_width{1'b1}};
    else
assign last_refill =  1'b1;
endgenerate
assign read_port_enable = (stall_x ==  1'b0);
assign write_port_enable = (refill_ready ==  1'b1) || !stall_m;
assign valid_store = (store_q_m ==  1'b1) && (check ==  1'b1);
generate
    if (associativity == 1) 
    begin : we_1     
assign way_dmem_we[0] = (refill_ready ==  1'b1) || ((valid_store ==  1'b1) && (way_match[0] ==  1'b1));
assign way_tmem_we[0] = (refill_ready ==  1'b1) || (flushing ==  1'b1);
    end 
    else 
    begin : we_2
assign way_dmem_we[0] = ((refill_ready ==  1'b1) && (refill_way_select[0] ==  1'b1)) || ((valid_store ==  1'b1) && (way_match[0] ==  1'b1));
assign way_dmem_we[1] = ((refill_ready ==  1'b1) && (refill_way_select[1] ==  1'b1)) || ((valid_store ==  1'b1) && (way_match[1] ==  1'b1));
assign way_tmem_we[0] = ((refill_ready ==  1'b1) && (refill_way_select[0] ==  1'b1)) || (flushing ==  1'b1);
assign way_tmem_we[1] = ((refill_ready ==  1'b1) && (refill_way_select[1] ==  1'b1)) || (flushing ==  1'b1);
    end
endgenerate
assign tmem_write_data[ 0] = ((last_refill ==  1'b1) || (valid_store ==  1'b1)) && (flushing ==  1'b0);
assign tmem_write_data[ ((addr_tag_width+1)-1):1] = refill_address[ addr_tag_msb:addr_tag_lsb];
assign flushing = state[0];
assign check = state[1];
assign refill = state[2];
assign miss = (~(|way_match)) && (load_q_m ==  1'b1) && (stall_m ==  1'b0);
assign stall_request = (check ==  1'b0);
generate
    if (associativity >= 2) 
    begin : way_select      
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_way_select <= {{associativity-1{1'b0}}, 1'b1};
    else
    begin        
        if (refill_request ==  1'b1)
            refill_way_select <= {refill_way_select[0], refill_way_select[1]};
    end
end
    end 
endgenerate   
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refilling <=  1'b0;
    else 
        refilling <= refill;
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        state <=  3'b001;
        flush_set <= { addr_set_width{1'b1}};
        refill_request <=  1'b0;
        refill_address <= { 32{1'bx}};
        restart_request <=  1'b0;
    end
    else 
    begin
        case (state)
         3'b001:
        begin
            if (flush_set == { addr_set_width{1'b0}})
                state <=  3'b010;
            flush_set <= flush_set - 1'b1;
        end
         3'b010:
        begin
            if (stall_a ==  1'b0)
                restart_request <=  1'b0;
            if (miss ==  1'b1)
            begin
                refill_request <=  1'b1;
                refill_address <= address_m;
                state <=  3'b100;
            end
            else if (dflush ==  1'b1)
                state <=  3'b001;
        end
         3'b100:
        begin
            refill_request <=  1'b0;
            if (refill_ready ==  1'b1)
            begin
                if (last_refill ==  1'b1)
                begin
                    restart_request <=  1'b1;
                    state <=  3'b010;
                end
            end
        end
        endcase        
    end
end
generate
    if (bytes_per_line > 4)
    begin
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_offset <= {addr_offset_width{1'b0}};
    else 
    begin
        case (state)
         3'b010:
        begin
            if (miss ==  1'b1)
                refill_offset <= {addr_offset_width{1'b0}};
        end
         3'b100:
        begin
            if (refill_ready ==  1'b1)
                refill_offset <= refill_offset + 1'b1;
        end
        endcase        
    end
end
    end
endgenerate
endmodule
module lm32_instruction_unit_full (
    clk_i,
    rst_i,
    stall_a,
    stall_f,
    stall_d,
    stall_x,
    stall_m,
    valid_f,
    valid_d,
    kill_f,
    branch_predict_taken_d,
    branch_predict_address_d,
    branch_taken_x,
    branch_target_x,
    exception_m,
    branch_taken_m,
    branch_mispredict_taken_m,
    branch_target_m,
    iflush,
    dcache_restart_request,
    dcache_refill_request,
    dcache_refilling,
    i_dat_i,
    i_ack_i,
    i_err_i,
    i_rty_i,
    pc_f,
    pc_d,
    pc_x,
    pc_m,
    pc_w,
    icache_stall_request,
    icache_restart_request,
    icache_refill_request,
    icache_refilling,
    i_dat_o,
    i_adr_o,
    i_cyc_o,
    i_sel_o,
    i_stb_o,
    i_we_o,
    i_cti_o,
    i_lock_o,
    i_bte_o,
    bus_error_d,
    instruction_f,
    instruction_d
    );
parameter eba_reset =  32'h00000000;                   
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam eba_reset_minus_4 = eba_reset - 4;
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_f;                                          
input stall_d;                                          
input stall_x;                                          
input stall_m;                                          
input valid_f;                                          
input valid_d;                                          
input kill_f;                                           
input branch_predict_taken_d;                           
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_predict_address_d;          
input branch_taken_x;                                   
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_x;                   
input exception_m;
input branch_taken_m;                                   
input branch_mispredict_taken_m;                        
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_m;                   
input iflush;                                           
input dcache_restart_request;                           
input dcache_refill_request;                            
input dcache_refilling;
input [ (32-1):0] i_dat_i;                         
input i_ack_i;                                          
input i_err_i;                                          
input i_rty_i;                                          
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;
output icache_stall_request;                            
wire   icache_stall_request;
output icache_restart_request;                          
wire   icache_restart_request;
output icache_refill_request;                           
wire   icache_refill_request;
output icache_refilling;                                
wire   icache_refilling;
output [ (32-1):0] i_dat_o;                        
wire   [ (32-1):0] i_dat_o;
output [ (32-1):0] i_adr_o;                        
reg    [ (32-1):0] i_adr_o;
output i_cyc_o;                                         
reg    i_cyc_o; 
output [ (4-1):0] i_sel_o;                 
wire   [ (4-1):0] i_sel_o;
output i_stb_o;                                         
reg    i_stb_o;
output i_we_o;                                          
wire   i_we_o;
output [ (3-1):0] i_cti_o;                       
reg    [ (3-1):0] i_cti_o;
output i_lock_o;                                        
reg    i_lock_o;
output [ (2-1):0] i_bte_o;                       
wire   [ (2-1):0] i_bte_o;
output bus_error_d;                                     
reg    bus_error_d;
output [ (32-1):0] instruction_f;           
wire   [ (32-1):0] instruction_f;
output [ (32-1):0] instruction_d;           
reg    [ (32-1):0] instruction_d;
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_a;                                
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] restart_address;                     
wire icache_read_enable_f;                              
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] icache_refill_address;              
reg icache_refill_ready;                                
reg [ (32-1):0] icache_refill_data;         
wire [ (32-1):0] icache_data_f;             
wire [ (3-1):0] first_cycle_type;                
wire [ (3-1):0] next_cycle_type;                 
wire last_word;                                         
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] first_address;                      
reg bus_error_f;                                        
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_icache_full #(
    .associativity          (associativity),
    .sets                   (sets),
    .bytes_per_line         (bytes_per_line),
    .base_address           (base_address),
    .limit                  (limit)
    ) icache ( 
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),      
    .stall_a                (stall_a),
    .stall_f                (stall_f),
    .branch_predict_taken_d (branch_predict_taken_d),
    .valid_d                (valid_d),
    .address_a              (pc_a),
    .address_f              (pc_f),
    .read_enable_f          (icache_read_enable_f),
    .refill_ready           (icache_refill_ready),
    .refill_data            (icache_refill_data),
    .iflush                 (iflush),
    .stall_request          (icache_stall_request),
    .restart_request        (icache_restart_request),
    .refill_request         (icache_refill_request),
    .refill_address         (icache_refill_address),
    .refilling              (icache_refilling),
    .inst                   (icache_data_f)
    );
assign icache_read_enable_f =    (valid_f ==  1'b1)
                              && (kill_f ==  1'b0)
                              && (dcache_restart_request ==  1'b0)
                              ;
always @(*)
begin
    if (dcache_restart_request ==  1'b1)
        pc_a = restart_address;
    else 
      if (branch_taken_m ==  1'b1)
	if ((branch_mispredict_taken_m ==  1'b1) && (exception_m ==  1'b0))
	  pc_a = pc_x;
	else
          pc_a = branch_target_m;
      else if (branch_taken_x ==  1'b1)
        pc_a = branch_target_x;
      else
	if ( (valid_d ==  1'b1) && (branch_predict_taken_d ==  1'b1) )
	  pc_a = branch_predict_address_d;
	else
          if (icache_restart_request ==  1'b1)
            pc_a = restart_address;
	  else 
            pc_a = pc_f + 1'b1;
end
assign instruction_f = icache_data_f;
assign i_dat_o = 32'd0;
assign i_we_o =  1'b0;
assign i_sel_o = 4'b1111;
assign i_bte_o =  2'b00;
generate
    case (bytes_per_line)
    4:
    begin
assign first_cycle_type =  3'b111;
assign next_cycle_type =  3'b111;
assign last_word =  1'b1;
assign first_address = icache_refill_address;
    end
    8:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type =  3'b111;
assign last_word = i_adr_o[addr_offset_msb:addr_offset_lsb] == 1'b1;
assign first_address = {icache_refill_address[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:addr_offset_msb+1], {addr_offset_width{1'b0}}};
    end
    16:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type = i_adr_o[addr_offset_msb] == 1'b1 ?  3'b111 :  3'b010;
assign last_word = i_adr_o[addr_offset_msb:addr_offset_lsb] == 2'b11;
assign first_address = {icache_refill_address[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:addr_offset_msb+1], {addr_offset_width{1'b0}}};
    end
    endcase
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        pc_f <= eba_reset_minus_4[ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2];
        pc_d <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_x <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_m <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_w <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
    end
    else
    begin
        if (stall_f ==  1'b0)
            pc_f <= pc_a;
        if (stall_d ==  1'b0)
            pc_d <= pc_f;
        if (stall_x ==  1'b0)
            pc_x <= pc_d;
        if (stall_m ==  1'b0)
            pc_m <= pc_x;
        pc_w <= pc_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        restart_address <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
    else
    begin
            if (dcache_refill_request ==  1'b1)
                restart_address <= pc_w;
            else if ((icache_refill_request ==  1'b1) && (!dcache_refilling) && (!dcache_restart_request))
                restart_address <= icache_refill_address;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        i_cyc_o <=  1'b0;
        i_stb_o <=  1'b0;
        i_adr_o <= { 32{1'b0}};
        i_cti_o <=  3'b111;
        i_lock_o <=  1'b0;
        icache_refill_data <= { 32{1'b0}};
        icache_refill_ready <=  1'b0;
        bus_error_f <=  1'b0;
    end
    else
    begin   
        icache_refill_ready <=  1'b0;
        if (i_cyc_o ==  1'b1)
        begin
            if ((i_ack_i ==  1'b1) || (i_err_i ==  1'b1))
            begin
                begin
                    if (last_word ==  1'b1)
                    begin
                        i_cyc_o <=  1'b0;
                        i_stb_o <=  1'b0;
                        i_lock_o <=  1'b0;
                    end
                    i_adr_o[addr_offset_msb:addr_offset_lsb] <= i_adr_o[addr_offset_msb:addr_offset_lsb] + 1'b1;
                    i_cti_o <= next_cycle_type;
                    icache_refill_ready <=  1'b1;
                    icache_refill_data <= i_dat_i;
                end
            end
            if (i_err_i ==  1'b1)
            begin
                bus_error_f <=  1'b1;
                $display ("Instruction bus error. Address: %x", i_adr_o);
            end
        end
        else
        begin
            if ((icache_refill_request ==  1'b1) && (icache_refill_ready ==  1'b0))
            begin
                i_adr_o <= {first_address, 2'b00};
                i_cyc_o <=  1'b1;
                i_stb_o <=  1'b1;                
                i_cti_o <= first_cycle_type;
                bus_error_f <=  1'b0;
            end
            if (branch_taken_x ==  1'b1)
                bus_error_f <=  1'b0;
            if (branch_taken_m ==  1'b1)
                bus_error_f <=  1'b0;
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        instruction_d <= { 32{1'b0}};
        bus_error_d <=  1'b0;
    end
    else
    begin
        if (stall_d ==  1'b0)
        begin
            instruction_d <= instruction_f;
            bus_error_d <= bus_error_f;
        end
    end
end  
endmodule
module lm32_interrupt_full (
    clk_i, 
    rst_i,
    interrupt,
    stall_x,
    exception,
    eret_q_x,
    csr,
    csr_write_data,
    csr_write_enable,
    interrupt_exception,
    csr_read_data
    );
parameter interrupts =  32;         
input clk_i;                                    
input rst_i;                                    
input [interrupts-1:0] interrupt;               
input stall_x;                                  
input exception;                                
input eret_q_x;                                 
input [ (4 -1):0] csr;                      
input [ (32-1):0] csr_write_data;          
input csr_write_enable;                         
output interrupt_exception;                     
wire   interrupt_exception;
output [ (32-1):0] csr_read_data;          
reg    [ (32-1):0] csr_read_data;
wire [interrupts-1:0] asserted;                 
wire [interrupts-1:0] interrupt_n_exception;
reg ie;                                         
reg eie;                                        
reg [interrupts-1:0] ip;                        
reg [interrupts-1:0] im;                        
assign interrupt_n_exception = ip & im;
assign interrupt_exception = (|interrupt_n_exception) & ie;
assign asserted = ip | interrupt;
generate
    if (interrupts > 1) 
    begin
always @(*)
begin
    case (csr)
     4 'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    1'b0,                                     
                                    eie, 
                                    ie
                                   };
     4 'h2:  csr_read_data = ip;
     4 'h1:  csr_read_data = im;
    default:       csr_read_data = { 32{1'bx}};
    endcase
end
    end
    else
    begin
always @(*)
begin
    case (csr)
     4 'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    1'b0,                                    
                                    eie, 
                                    ie
                                   };
     4 'h2:  csr_read_data = ip;
    default:       csr_read_data = { 32{1'bx}};
      endcase
end
    end
endgenerate
   reg [ 10:0] eie_delay  = 0;
generate
    if (interrupts > 1)
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie                   <=  1'b0;
        eie                  <=  1'b0;
        im                   <= {interrupts{1'b0}};
        ip                   <= {interrupts{1'b0}};
       eie_delay             <= 0;
    end
    else
    begin
        ip                   <= asserted;
        if (exception ==  1'b1)
        begin
            eie              <= ie;
            ie               <=  1'b0;
        end
        else if (stall_x ==  1'b0)
        begin
           if(eie_delay[0])
             ie              <= eie;
           eie_delay         <= {1'b0, eie_delay[ 10:1]};
            if (eret_q_x ==  1'b1) begin
               eie_delay[ 10] <=  1'b1;
               eie_delay[ 10-1:0] <= 0;
            end
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  4 'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                end
                if (csr ==  4 'h1)
                    im  <= csr_write_data[interrupts-1:0];
                if (csr ==  4 'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
else
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie              <=  1'b0;
        eie             <=  1'b0;
        ip              <= {interrupts{1'b0}};
       eie_delay        <= 0;
    end
    else
    begin
        ip              <= asserted;
        if (exception ==  1'b1)
        begin
            eie         <= ie;
            ie          <=  1'b0;
        end
        else if (stall_x ==  1'b0)
          begin
             if(eie_delay[0])
               ie              <= eie;
             eie_delay         <= {1'b0, eie_delay[ 10:1]};
             if (eret_q_x ==  1'b1) begin
                eie_delay[ 10] <=  1'b1;
                eie_delay[ 10-1:0] <= 0;
             end
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  4 'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                end
                if (csr ==  4 'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
endgenerate
endmodule
module lm32_top_full_debug (
    clk_i,
    rst_i,
    interrupt,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset = 32'h00000000;
parameter sdb_address = 32'h00000000;
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
wire [ 7:0] jtag_reg_d;
wire [ 7:0] jtag_reg_q;
wire jtag_update;
wire [2:0] jtag_reg_addr_d;
wire [2:0] jtag_reg_addr_q;
wire jtck;
wire jrstn;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_cpu_full_debug 
	#(
		.eba_reset(eba_reset),
    .sdb_address(sdb_address)
	) cpu (
    .clk_i                 (clk_i),
    .rst_i                 (rst_i),
    .interrupt             (interrupt),
    .jtag_clk              (jtck),
    .jtag_update           (jtag_update),
    .jtag_reg_q            (jtag_reg_q),
    .jtag_reg_addr_q       (jtag_reg_addr_q),
    .I_DAT_I               (I_DAT_I),
    .I_ACK_I               (I_ACK_I),
    .I_ERR_I               (I_ERR_I),
    .I_RTY_I               (I_RTY_I),
    .D_DAT_I               (D_DAT_I),
    .D_ACK_I               (D_ACK_I),
    .D_ERR_I               (D_ERR_I),
    .D_RTY_I               (D_RTY_I),
    .jtag_reg_d            (jtag_reg_d),
    .jtag_reg_addr_d       (jtag_reg_addr_d),
    .I_DAT_O               (I_DAT_O),
    .I_ADR_O               (I_ADR_O),
    .I_CYC_O               (I_CYC_O),
    .I_SEL_O               (I_SEL_O),
    .I_STB_O               (I_STB_O),
    .I_WE_O                (I_WE_O),
    .I_CTI_O               (I_CTI_O),
    .I_LOCK_O              (I_LOCK_O),
    .I_BTE_O               (I_BTE_O),
    .D_DAT_O               (D_DAT_O),
    .D_ADR_O               (D_ADR_O),
    .D_CYC_O               (D_CYC_O),
    .D_SEL_O               (D_SEL_O),
    .D_STB_O               (D_STB_O),
    .D_WE_O                (D_WE_O),
    .D_CTI_O               (D_CTI_O),
    .D_LOCK_O              (D_LOCK_O),
    .D_BTE_O               (D_BTE_O)
    );
jtag_cores jtag_cores (
    .reg_d                 (jtag_reg_d),
    .reg_addr_d            (jtag_reg_addr_d),
    .reg_update            (jtag_update),
    .reg_q                 (jtag_reg_q),
    .reg_addr_q            (jtag_reg_addr_q),
    .jtck                  (jtck),
    .jrstn                 (jrstn)
    );
endmodule
module lm32_mc_arithmetic_full_debug (
    clk_i,
    rst_i,
    stall_d,
    kill_x,
    divide_d,
    modulus_d,
    operand_0_d,
    operand_1_d,
    result_x,
    divide_by_zero_x,
    stall_request_x
    );
input clk_i;                                    
input rst_i;                                    
input stall_d;                                  
input kill_x;                                   
input divide_d;                                 
input modulus_d;                                
input [ (32-1):0] operand_0_d;
input [ (32-1):0] operand_1_d;
output [ (32-1):0] result_x;               
reg    [ (32-1):0] result_x;
output divide_by_zero_x;                        
reg    divide_by_zero_x;
output stall_request_x;                         
wire   stall_request_x;
reg [ (32-1):0] p;                         
reg [ (32-1):0] a;
reg [ (32-1):0] b;
wire [32:0] t;
reg [ 2:0] state;                 
reg [5:0] cycles;                               
assign stall_request_x = state !=  3'b000;
assign t = {p[ 32-2:0], a[ 32-1]} - b;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        cycles <= {6{1'b0}};
        p <= { 32{1'b0}};
        a <= { 32{1'b0}};
        b <= { 32{1'b0}};
        divide_by_zero_x <=  1'b0;
        result_x <= { 32{1'b0}};
        state <=  3'b000;
    end
    else
    begin
        divide_by_zero_x <=  1'b0;
        case (state)
         3'b000:
        begin
            if (stall_d ==  1'b0)                 
            begin          
                cycles <=  32;
                p <= 32'b0;
                a <= operand_0_d;
                b <= operand_1_d;                    
                if (divide_d ==  1'b1)
                    state <=  3'b011 ;
                if (modulus_d ==  1'b1)
                    state <=  3'b010   ;
            end            
        end
         3'b011 :
        begin
            if (t[32] == 1'b0)
            begin
                p <= t[31:0];
                a <= {a[ 32-2:0], 1'b1};
            end
            else 
            begin
                p <= {p[ 32-2:0], a[ 32-1]};
                a <= {a[ 32-2:0], 1'b0};
            end
            result_x <= a;
            if ((cycles ==  32'd0) || (kill_x ==  1'b1))
            begin
                divide_by_zero_x <= b == { 32{1'b0}};
                state <=  3'b000;
            end
            cycles <= cycles - 1'b1;
        end
         3'b010   :
        begin
            if (t[32] == 1'b0)
            begin
                p <= t[31:0];
                a <= {a[ 32-2:0], 1'b1};
            end
            else 
            begin
                p <= {p[ 32-2:0], a[ 32-1]};
                a <= {a[ 32-2:0], 1'b0};
            end
            result_x <= p;
            if ((cycles ==  32'd0) || (kill_x ==  1'b1))
            begin
                divide_by_zero_x <= b == { 32{1'b0}};
                state <=  3'b000;
            end
            cycles <= cycles - 1'b1;
        end
        endcase
    end
end 
endmodule
module lm32_cpu_full_debug (
    clk_i,
    rst_i,
    interrupt,
    jtag_clk,
    jtag_update, 
    jtag_reg_q,
    jtag_reg_addr_q,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    jtag_reg_d,
    jtag_reg_addr_d,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset =  32'h00000000;                           
parameter deba_reset =  32'h10000000;                         
parameter sdb_address =   32'h00000000;
parameter icache_associativity =  1;     
parameter icache_sets =  256;                       
parameter icache_bytes_per_line =  16;   
parameter icache_base_address =  32'h0;       
parameter icache_limit =  32'h7fffffff;                     
parameter dcache_associativity =  1;     
parameter dcache_sets =  256;                       
parameter dcache_bytes_per_line =  16;   
parameter dcache_base_address =  32'h0;       
parameter dcache_limit =  32'h7fffffff;                     
parameter watchpoints =  32'h4;                       
parameter breakpoints = 0;
parameter interrupts =  32;                         
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input jtag_clk;                                 
input jtag_update;                              
input [ 7:0] jtag_reg_q;              
input [2:0] jtag_reg_addr_q;
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ 7:0] jtag_reg_d;
wire   [ 7:0] jtag_reg_d;
output [2:0] jtag_reg_addr_d;
wire   [2:0] jtag_reg_addr_d;
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
reg valid_a;                                    
reg valid_f;                                    
reg valid_d;                                    
reg valid_x;                                    
reg valid_m;                                    
reg valid_w;                                    
wire q_x;
wire [ (32-1):0] immediate_d;              
wire load_d;                                    
reg load_x;                                     
reg load_m;
wire load_q_x;
wire store_q_x;
wire q_m;
wire load_q_m;
wire store_q_m;
wire store_d;                                   
reg store_x;
reg store_m;
wire [ 1:0] size_d;                   
reg [ 1:0] size_x;
wire branch_d;                                  
wire branch_predict_d;                          
wire branch_predict_taken_d;                    
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_predict_address_d;   
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_d;
wire bi_unconditional;
wire bi_conditional;
reg branch_x;                                   
reg branch_predict_x;
reg branch_predict_taken_x;
reg branch_m;
reg branch_predict_m;
reg branch_predict_taken_m;
wire branch_mispredict_taken_m;                 
wire branch_flushX_m;                           
wire branch_reg_d;                              
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset_d;            
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_x;             
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_m;
wire [ 0:0] d_result_sel_0_d; 
wire [ 1:0] d_result_sel_1_d; 
wire x_result_sel_csr_d;                        
reg x_result_sel_csr_x;
wire q_d;
wire x_result_sel_mc_arith_d;                   
reg x_result_sel_mc_arith_x;
wire x_result_sel_sext_d;                       
reg x_result_sel_sext_x;
wire x_result_sel_logic_d;                      
wire x_result_sel_add_d;                        
reg x_result_sel_add_x;
wire m_result_sel_compare_d;                    
reg m_result_sel_compare_x;
reg m_result_sel_compare_m;
wire m_result_sel_shift_d;                      
reg m_result_sel_shift_x;
reg m_result_sel_shift_m;
wire w_result_sel_load_d;                       
reg w_result_sel_load_x;
reg w_result_sel_load_m;
reg w_result_sel_load_w;
wire w_result_sel_mul_d;                        
reg w_result_sel_mul_x;
reg w_result_sel_mul_m;
reg w_result_sel_mul_w;
wire x_bypass_enable_d;                         
reg x_bypass_enable_x;                          
wire m_bypass_enable_d;                         
reg m_bypass_enable_x;                          
reg m_bypass_enable_m;
wire sign_extend_d;                             
reg sign_extend_x;
wire write_enable_d;                            
reg write_enable_x;
wire write_enable_q_x;
reg write_enable_m;
wire write_enable_q_m;
reg write_enable_w;
wire write_enable_q_w;
wire read_enable_0_d;                           
wire [ (5-1):0] read_idx_0_d;          
wire read_enable_1_d;                           
wire [ (5-1):0] read_idx_1_d;          
wire [ (5-1):0] write_idx_d;           
reg [ (5-1):0] write_idx_x;            
reg [ (5-1):0] write_idx_m;
reg [ (5-1):0] write_idx_w;
wire [ (5-1):0] csr_d;                     
reg  [ (5-1):0] csr_x;                  
wire [ (3-1):0] condition_d;         
reg [ (3-1):0] condition_x;          
wire break_d;                                   
reg break_x;                                    
wire scall_d;                                   
reg scall_x;    
wire eret_d;                                    
reg eret_x;
wire eret_q_x;
wire bret_d;                                    
reg bret_x;
wire bret_q_x;
wire csr_write_enable_d;                        
reg csr_write_enable_x;
wire csr_write_enable_q_x;
wire bus_error_d;                               
reg bus_error_x;
reg data_bus_error_exception_m;
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] memop_pc_w;
reg [ (32-1):0] d_result_0;                
reg [ (32-1):0] d_result_1;                
reg [ (32-1):0] x_result;                  
reg [ (32-1):0] m_result;                  
reg [ (32-1):0] w_result;                  
reg [ (32-1):0] operand_0_x;               
reg [ (32-1):0] operand_1_x;               
reg [ (32-1):0] store_operand_x;           
reg [ (32-1):0] operand_m;                 
reg [ (32-1):0] operand_w;                 
reg [ (32-1):0] reg_data_live_0;          
reg [ (32-1):0] reg_data_live_1;  
reg use_buf;                                    
reg [ (32-1):0] reg_data_buf_0;
reg [ (32-1):0] reg_data_buf_1;
wire [ (32-1):0] reg_data_0;               
wire [ (32-1):0] reg_data_1;               
reg [ (32-1):0] bypass_data_0;             
reg [ (32-1):0] bypass_data_1;             
wire reg_write_enable_q_w;
reg interlock;                                  
wire stall_a;                                   
wire stall_f;                                   
wire stall_d;                                   
wire stall_x;                                   
wire stall_m;                                   
wire adder_op_d;                                
reg adder_op_x;                                 
reg adder_op_x_n;                               
wire [ (32-1):0] adder_result_x;           
wire adder_overflow_x;                          
wire adder_carry_n_x;                           
wire [ 3:0] logic_op_d;           
reg [ 3:0] logic_op_x;            
wire [ (32-1):0] logic_result_x;           
wire [ (32-1):0] sextb_result_x;           
wire [ (32-1):0] sexth_result_x;           
wire [ (32-1):0] sext_result_x;            
wire direction_d;                               
reg direction_x;                                        
wire [ (32-1):0] shifter_result_m;         
wire [ (32-1):0] multiplier_result_w;      
wire divide_d;                                  
wire divide_q_d;
wire modulus_d;
wire modulus_q_d;
wire divide_by_zero_x;                          
wire mc_stall_request_x;                        
wire [ (32-1):0] mc_result_x;
wire [ (32-1):0] interrupt_csr_read_data_x;
wire [ (32-1):0] cfg;                      
wire [ (32-1):0] cfg2;                     
reg [ (32-1):0] csr_read_data_x;           
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;                       
wire [ (32-1):0] instruction_f;     
wire [ (32-1):0] instruction_d;     
wire iflush;                                    
wire icache_stall_request;                      
wire icache_restart_request;                    
wire icache_refill_request;                     
wire icache_refilling;                          
wire dflush_x;                                  
reg dflush_m;                                    
wire dcache_stall_request;                      
wire dcache_restart_request;                    
wire dcache_refill_request;                     
wire dcache_refilling;                          
wire [ (32-1):0] load_data_w;              
wire stall_wb_load;                             
wire [ (32-1):0] jtx_csr_read_data;        
wire [ (32-1):0] jrx_csr_read_data;        
wire jtag_csr_write_enable;                     
wire [ (32-1):0] jtag_csr_write_data;      
wire [ (5-1):0] jtag_csr;                  
wire jtag_read_enable;                          
wire [ 7:0] jtag_read_data;
wire jtag_write_enable;
wire [ 7:0] jtag_write_data;
wire [ (32-1):0] jtag_address;
wire jtag_access_complete;
wire jtag_break;                                
wire raw_x_0;                                   
wire raw_x_1;                                   
wire raw_m_0;                                   
wire raw_m_1;                                   
wire raw_w_0;                                   
wire raw_w_1;                                   
wire cmp_zero;                                  
wire cmp_negative;                              
wire cmp_overflow;                              
wire cmp_carry_n;                               
reg condition_met_x;                            
reg condition_met_m;
wire branch_taken_x;                            
wire branch_taken_m;                            
wire kill_f;                                    
wire kill_d;                                    
wire kill_x;                                    
wire kill_m;                                    
wire kill_w;                                    
reg [ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8] eba;                 
reg [ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8] deba;                
reg [ (3-1):0] eid_x;                      
wire dc_ss;                                     
wire dc_re;                                     
wire bp_match;
wire wp_match;
wire exception_x;                               
reg exception_m;                                
wire debug_exception_x;                         
reg debug_exception_m;
reg debug_exception_w;
wire debug_exception_q_w;
wire non_debug_exception_x;                     
reg non_debug_exception_m;
reg non_debug_exception_w;
wire non_debug_exception_q_w;
wire reset_exception;                           
wire interrupt_exception;                       
wire breakpoint_exception;                      
wire watchpoint_exception;                      
wire instruction_bus_error_exception;           
wire data_bus_error_exception;                  
wire divide_by_zero_exception;                  
wire system_call_exception;                     
reg data_bus_error_seen;                        
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_instruction_unit_full_debug #(
    .eba_reset              (eba_reset),
    .associativity          (icache_associativity),
    .sets                   (icache_sets),
    .bytes_per_line         (icache_bytes_per_line),
    .base_address           (icache_base_address),
    .limit                  (icache_limit)
  ) instruction_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_f                (stall_f),
    .stall_d                (stall_d),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .valid_f                (valid_f),
    .valid_d                (valid_d),
    .kill_f                 (kill_f),
    .branch_predict_taken_d (branch_predict_taken_d),
    .branch_predict_address_d (branch_predict_address_d),
    .branch_taken_x         (branch_taken_x),
    .branch_target_x        (branch_target_x),
    .exception_m            (exception_m),
    .branch_taken_m         (branch_taken_m),
    .branch_mispredict_taken_m (branch_mispredict_taken_m),
    .branch_target_m        (branch_target_m),
    .iflush                 (iflush),
    .dcache_restart_request (dcache_restart_request),
    .dcache_refill_request  (dcache_refill_request),
    .dcache_refilling       (dcache_refilling),
    .i_dat_i                (I_DAT_I),
    .i_ack_i                (I_ACK_I),
    .i_err_i                (I_ERR_I),
    .i_rty_i                (I_RTY_I),
    .jtag_read_enable       (jtag_read_enable),
    .jtag_write_enable      (jtag_write_enable),
    .jtag_write_data        (jtag_write_data),
    .jtag_address           (jtag_address),
    .pc_f                   (pc_f),
    .pc_d                   (pc_d),
    .pc_x                   (pc_x),
    .pc_m                   (pc_m),
    .pc_w                   (pc_w),
    .icache_stall_request   (icache_stall_request),
    .icache_restart_request (icache_restart_request),
    .icache_refill_request  (icache_refill_request),
    .icache_refilling       (icache_refilling),
    .i_dat_o                (I_DAT_O),
    .i_adr_o                (I_ADR_O),
    .i_cyc_o                (I_CYC_O),
    .i_sel_o                (I_SEL_O),
    .i_stb_o                (I_STB_O),
    .i_we_o                 (I_WE_O),
    .i_cti_o                (I_CTI_O),
    .i_lock_o               (I_LOCK_O),
    .i_bte_o                (I_BTE_O),
    .jtag_read_data         (jtag_read_data),
    .jtag_access_complete   (jtag_access_complete),
    .bus_error_d            (bus_error_d),
    .instruction_f          (instruction_f),
    .instruction_d          (instruction_d)
    );
lm32_decoder_full_debug decoder (
    .instruction            (instruction_d),
    .d_result_sel_0         (d_result_sel_0_d),
    .d_result_sel_1         (d_result_sel_1_d),
    .x_result_sel_csr       (x_result_sel_csr_d),
    .x_result_sel_mc_arith  (x_result_sel_mc_arith_d),
    .x_result_sel_sext      (x_result_sel_sext_d),
    .x_result_sel_logic     (x_result_sel_logic_d),
    .x_result_sel_add       (x_result_sel_add_d),
    .m_result_sel_compare   (m_result_sel_compare_d),
    .m_result_sel_shift     (m_result_sel_shift_d),  
    .w_result_sel_load      (w_result_sel_load_d),
    .w_result_sel_mul       (w_result_sel_mul_d),
    .x_bypass_enable        (x_bypass_enable_d),
    .m_bypass_enable        (m_bypass_enable_d),
    .read_enable_0          (read_enable_0_d),
    .read_idx_0             (read_idx_0_d),
    .read_enable_1          (read_enable_1_d),
    .read_idx_1             (read_idx_1_d),
    .write_enable           (write_enable_d),
    .write_idx              (write_idx_d),
    .immediate              (immediate_d),
    .branch_offset          (branch_offset_d),
    .load                   (load_d),
    .store                  (store_d),
    .size                   (size_d),
    .sign_extend            (sign_extend_d),
    .adder_op               (adder_op_d),
    .logic_op               (logic_op_d),
    .direction              (direction_d),
    .divide                 (divide_d),
    .modulus                (modulus_d),
    .branch                 (branch_d),
    .bi_unconditional       (bi_unconditional),
    .bi_conditional         (bi_conditional),
    .branch_reg             (branch_reg_d),
    .condition              (condition_d),
    .break_opcode           (break_d),
    .scall                  (scall_d),
    .eret                   (eret_d),
    .bret                   (bret_d),
    .csr_write_enable       (csr_write_enable_d)
    ); 
lm32_load_store_unit_full_debug #(
    .associativity          (dcache_associativity),
    .sets                   (dcache_sets),
    .bytes_per_line         (dcache_bytes_per_line),
    .base_address           (dcache_base_address),
    .limit                  (dcache_limit)
  ) load_store_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .kill_x                 (kill_x),
    .kill_m                 (kill_m),
    .exception_m            (exception_m),
    .store_operand_x        (store_operand_x),
    .load_store_address_x   (adder_result_x),
    .load_store_address_m   (operand_m),
    .load_store_address_w   (operand_w[1:0]),
    .load_x                 (load_x),
    .store_x                (store_x),
    .load_q_x               (load_q_x),
    .store_q_x              (store_q_x),
    .load_q_m               (load_q_m),
    .store_q_m              (store_q_m),
    .sign_extend_x          (sign_extend_x),
    .size_x                 (size_x),
    .dflush                 (dflush_m),
    .d_dat_i                (D_DAT_I),
    .d_ack_i                (D_ACK_I),
    .d_err_i                (D_ERR_I),
    .d_rty_i                (D_RTY_I),
    .dcache_refill_request  (dcache_refill_request),
    .dcache_restart_request (dcache_restart_request),
    .dcache_stall_request   (dcache_stall_request),
    .dcache_refilling       (dcache_refilling),
    .load_data_w            (load_data_w),
    .stall_wb_load          (stall_wb_load),
    .d_dat_o                (D_DAT_O),
    .d_adr_o                (D_ADR_O),
    .d_cyc_o                (D_CYC_O),
    .d_sel_o                (D_SEL_O),
    .d_stb_o                (D_STB_O),
    .d_we_o                 (D_WE_O),
    .d_cti_o                (D_CTI_O),
    .d_lock_o               (D_LOCK_O),
    .d_bte_o                (D_BTE_O)
    );      
lm32_adder adder (
    .adder_op_x             (adder_op_x),
    .adder_op_x_n           (adder_op_x_n),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .adder_result_x         (adder_result_x),
    .adder_carry_n_x        (adder_carry_n_x),
    .adder_overflow_x       (adder_overflow_x)
    );
lm32_logic_op logic_op (
    .logic_op_x             (logic_op_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .logic_result_x         (logic_result_x)
    );
lm32_shifter shifter (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .direction_x            (direction_x),
    .sign_extend_x          (sign_extend_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .shifter_result_m       (shifter_result_m)
    );
lm32_multiplier multiplier (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .operand_0              (d_result_0),
    .operand_1              (d_result_1),
    .result                 (multiplier_result_w)    
    );
lm32_mc_arithmetic_full_debug mc_arithmetic (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_d                (stall_d),
    .kill_x                 (kill_x),
    .divide_d               (divide_q_d),
    .modulus_d              (modulus_q_d),
    .operand_0_d            (d_result_0),
    .operand_1_d            (d_result_1),
    .result_x               (mc_result_x),
    .divide_by_zero_x       (divide_by_zero_x),
    .stall_request_x        (mc_stall_request_x)
    );
lm32_interrupt_full_debug interrupt_unit (
    .clk_i                  (clk_i), 
    .rst_i                  (rst_i),
    .interrupt              (interrupt),
    .stall_x                (stall_x),
    .non_debug_exception    (non_debug_exception_q_w), 
    .debug_exception        (debug_exception_q_w),
    .eret_q_x               (eret_q_x),
    .bret_q_x               (bret_q_x),
    .csr                    (csr_x),
    .csr_write_data         (operand_1_x),
    .csr_write_enable       (csr_write_enable_q_x),
    .interrupt_exception    (interrupt_exception),
    .csr_read_data          (interrupt_csr_read_data_x)
    );
lm32_jtag_full_debug jtag (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .jtag_clk               (jtag_clk),
    .jtag_update            (jtag_update),
    .jtag_reg_q             (jtag_reg_q),
    .jtag_reg_addr_q        (jtag_reg_addr_q),
    .csr                    (csr_x),
    .csr_write_data         (operand_1_x),
    .csr_write_enable       (csr_write_enable_q_x),
    .stall_x                (stall_x),
    .jtag_read_data         (jtag_read_data),
    .jtag_access_complete   (jtag_access_complete),
    .exception_q_w          (debug_exception_q_w || non_debug_exception_q_w),
    .jtx_csr_read_data      (jtx_csr_read_data),
    .jrx_csr_read_data      (jrx_csr_read_data),
    .jtag_csr_write_enable  (jtag_csr_write_enable),
    .jtag_csr_write_data    (jtag_csr_write_data),
    .jtag_csr               (jtag_csr),
    .jtag_read_enable       (jtag_read_enable),
    .jtag_write_enable      (jtag_write_enable),
    .jtag_write_data        (jtag_write_data),
    .jtag_address           (jtag_address),
    .jtag_break             (jtag_break),
    .jtag_reset             (reset_exception),
    .jtag_reg_d             (jtag_reg_d),
    .jtag_reg_addr_d        (jtag_reg_addr_d)
    );
lm32_debug_full_debug #(
    .breakpoints            (breakpoints),
    .watchpoints            (watchpoints)
  ) hw_debug (
    .clk_i                  (clk_i), 
    .rst_i                  (rst_i),
    .pc_x                   (pc_x),
    .load_x                 (load_x),
    .store_x                (store_x),
    .load_store_address_x   (adder_result_x),
    .csr_write_enable_x     (csr_write_enable_q_x),
    .csr_write_data         (operand_1_x),
    .csr_x                  (csr_x),
    .jtag_csr_write_enable  (jtag_csr_write_enable),
    .jtag_csr_write_data    (jtag_csr_write_data),
    .jtag_csr               (jtag_csr),
    .eret_q_x               (eret_q_x),
    .bret_q_x               (bret_q_x),
    .stall_x                (stall_x),
    .exception_x            (exception_x),
    .q_x                    (q_x),
    .dcache_refill_request  (dcache_refill_request),
    .dc_ss                  (dc_ss),
    .dc_re                  (dc_re),
    .bp_match               (bp_match),
    .wp_match               (wp_match)
    );
   wire [31:0] regfile_data_0, regfile_data_1;
   reg [31:0]  w_result_d;
   reg 	       regfile_raw_0, regfile_raw_0_nxt;
   reg 	       regfile_raw_1, regfile_raw_1_nxt;
   always @(reg_write_enable_q_w or write_idx_w or instruction_f)
     begin
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[25:21]))
	  regfile_raw_0_nxt = 1'b1;
	else
	  regfile_raw_0_nxt = 1'b0;
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[20:16]))
	  regfile_raw_1_nxt = 1'b1;
	else
	  regfile_raw_1_nxt = 1'b0;
     end
   always @(regfile_raw_0 or w_result_d or regfile_data_0)
     if (regfile_raw_0)
       reg_data_live_0 = w_result_d;
     else
       reg_data_live_0 = regfile_data_0;
   always @(regfile_raw_1 or w_result_d or regfile_data_1)
     if (regfile_raw_1)
       reg_data_live_1 = w_result_d;
     else
       reg_data_live_1 = regfile_data_1;
   always @(posedge clk_i  )
     if (rst_i ==  1'b1)
       begin
	  regfile_raw_0 <= 1'b0;
	  regfile_raw_1 <= 1'b0;
	  w_result_d <= 32'b0;
       end
     else
       begin
	  regfile_raw_0 <= regfile_raw_0_nxt;
	  regfile_raw_1 <= regfile_raw_1_nxt;
	  w_result_d <= w_result;
       end
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_0
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[25:21]),
      .rdata_o	(regfile_data_0)
      );
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_1
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[20:16]),
      .rdata_o	(regfile_data_1)
      );
assign reg_data_0 = use_buf ? reg_data_buf_0 : reg_data_live_0;
assign reg_data_1 = use_buf ? reg_data_buf_1 : reg_data_live_1;
assign raw_x_0 = (write_idx_x == read_idx_0_d) && (write_enable_q_x ==  1'b1);
assign raw_m_0 = (write_idx_m == read_idx_0_d) && (write_enable_q_m ==  1'b1);
assign raw_w_0 = (write_idx_w == read_idx_0_d) && (write_enable_q_w ==  1'b1);
assign raw_x_1 = (write_idx_x == read_idx_1_d) && (write_enable_q_x ==  1'b1);
assign raw_m_1 = (write_idx_m == read_idx_1_d) && (write_enable_q_m ==  1'b1);
assign raw_w_1 = (write_idx_w == read_idx_1_d) && (write_enable_q_w ==  1'b1);
always @(*)
begin
    if (   (   (x_bypass_enable_x ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_x_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_x_1 ==  1'b1))
               )
           )
        || (   (m_bypass_enable_m ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_m_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_m_1 ==  1'b1))
               )
           )
       )
        interlock =  1'b1;
    else
        interlock =  1'b0;
end
always @(*)
begin
    if (raw_x_0 ==  1'b1)        
        bypass_data_0 = x_result;
    else if (raw_m_0 ==  1'b1)
        bypass_data_0 = m_result;
    else if (raw_w_0 ==  1'b1)
        bypass_data_0 = w_result;
    else
        bypass_data_0 = reg_data_0;
end
always @(*)
begin
    if (raw_x_1 ==  1'b1)
        bypass_data_1 = x_result;
    else if (raw_m_1 ==  1'b1)
        bypass_data_1 = m_result;
    else if (raw_w_1 ==  1'b1)
        bypass_data_1 = w_result;
    else
        bypass_data_1 = reg_data_1;
end
   assign branch_predict_d = bi_unconditional | bi_conditional;
   assign branch_predict_taken_d = bi_unconditional ? 1'b1 : (bi_conditional ? instruction_d[15] : 1'b0);
   assign branch_target_d = pc_d + branch_offset_d;
   assign branch_predict_address_d = branch_predict_taken_d ? branch_target_d : pc_f;
always @(*)
begin
    d_result_0 = d_result_sel_0_d[0] ? {pc_f, 2'b00} : bypass_data_0; 
    case (d_result_sel_1_d)
     2'b00:      d_result_1 = { 32{1'b0}};
     2'b01:     d_result_1 = bypass_data_1;
     2'b10: d_result_1 = immediate_d;
    default:                        d_result_1 = { 32{1'bx}};
    endcase
end
assign sextb_result_x = {{24{operand_0_x[7]}}, operand_0_x[7:0]};
assign sexth_result_x = {{16{operand_0_x[15]}}, operand_0_x[15:0]};
assign sext_result_x = size_x ==  2'b00 ? sextb_result_x : sexth_result_x;
assign cmp_zero = operand_0_x == operand_1_x;
assign cmp_negative = adder_result_x[ 32-1];
assign cmp_overflow = adder_overflow_x;
assign cmp_carry_n = adder_carry_n_x;
always @(*)
begin
    case (condition_x)
     3'b000:   condition_met_x =  1'b1;
     3'b110:   condition_met_x =  1'b1;
     3'b001:    condition_met_x = cmp_zero;
     3'b111:   condition_met_x = !cmp_zero;
     3'b010:    condition_met_x = !cmp_zero && (cmp_negative == cmp_overflow);
     3'b101:   condition_met_x = cmp_carry_n && !cmp_zero;
     3'b011:   condition_met_x = cmp_negative == cmp_overflow;
     3'b100:  condition_met_x = cmp_carry_n;
    default:              condition_met_x = 1'bx;
    endcase 
end
always @(*)
begin
    x_result =   x_result_sel_add_x ? adder_result_x 
               : x_result_sel_csr_x ? csr_read_data_x
               : x_result_sel_sext_x ? sext_result_x
               : x_result_sel_mc_arith_x ? mc_result_x
               : logic_result_x;
end
always @(*)
begin
    m_result =   m_result_sel_compare_m ? {{ 32-1{1'b0}}, condition_met_m}
               : m_result_sel_shift_m ? shifter_result_m
               : operand_m; 
end
always @(*)
begin
    w_result =    w_result_sel_load_w ? load_data_w
                : w_result_sel_mul_w ? multiplier_result_w
                : operand_w;
end
assign branch_taken_x =      (stall_x ==  1'b0)
                          && (   (branch_x ==  1'b1)
                              && ((condition_x ==  3'b000) || (condition_x ==  3'b110))
                              && (valid_x ==  1'b1)
                              && (branch_predict_x ==  1'b0)
                             ); 
assign branch_taken_m =      (stall_m ==  1'b0) 
                          && (   (   (branch_m ==  1'b1) 
                                  && (valid_m ==  1'b1)
                                  && (   (   (condition_met_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b0)
					 )
				      || (   (condition_met_m ==  1'b0)
					  && (branch_predict_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b1)
					 )
				     )
                                 ) 
                              || (exception_m ==  1'b1)
                             );
assign branch_mispredict_taken_m =    (condition_met_m ==  1'b0)
                                   && (branch_predict_m ==  1'b1)
	   			   && (branch_predict_taken_m ==  1'b1);
assign branch_flushX_m =    (stall_m ==  1'b0)
                         && (   (   (branch_m ==  1'b1) 
                                 && (valid_m ==  1'b1)
			         && (   (condition_met_m ==  1'b1)
				     || (   (condition_met_m ==  1'b0)
					 && (branch_predict_m ==  1'b1)
					 && (branch_predict_taken_m ==  1'b1)
					)
				    )
			        )
			     || (exception_m ==  1'b1)
			    );
assign kill_f =    (   (valid_d ==  1'b1)
                    && (branch_predict_taken_d ==  1'b1)
		   )
                || (branch_taken_m ==  1'b1) 
                || (branch_taken_x ==  1'b1)
                || (icache_refill_request ==  1'b1) 
                || (dcache_refill_request ==  1'b1)
                ;
assign kill_d =    (branch_taken_m ==  1'b1) 
                || (branch_taken_x ==  1'b1)
                || (icache_refill_request ==  1'b1)     
                || (dcache_refill_request ==  1'b1)
                ;
assign kill_x =    (branch_flushX_m ==  1'b1) 
                || (dcache_refill_request ==  1'b1)
                ;
assign kill_m =     1'b0
                || (dcache_refill_request ==  1'b1)
                ;                
assign kill_w =     1'b0
                || (dcache_refill_request ==  1'b1)
                ;
assign breakpoint_exception =    (   (   (break_x ==  1'b1)
				      || (bp_match ==  1'b1)
				     )
				  && (valid_x ==  1'b1)
				 )
                              || (jtag_break ==  1'b1)
                              ;
assign watchpoint_exception = wp_match ==  1'b1;
assign instruction_bus_error_exception = (   (bus_error_x ==  1'b1)
                                          && (valid_x ==  1'b1)
                                         );
assign data_bus_error_exception = data_bus_error_seen ==  1'b1;
assign divide_by_zero_exception = divide_by_zero_x ==  1'b1;
assign system_call_exception = (   (scall_x ==  1'b1)
                                && (valid_x ==  1'b1)
			       );
assign debug_exception_x =  (breakpoint_exception ==  1'b1)
                         || (watchpoint_exception ==  1'b1)
                         ;
assign non_debug_exception_x = (system_call_exception ==  1'b1)
                            || (reset_exception ==  1'b1)
                            || (instruction_bus_error_exception ==  1'b1)
                            || (data_bus_error_exception ==  1'b1)
                            || (divide_by_zero_exception ==  1'b1)
                            || (   (interrupt_exception ==  1'b1)
                                && (dc_ss ==  1'b0)
 				&& (store_q_m ==  1'b0)
				&& (D_CYC_O ==  1'b0)
                               )
                            ;
assign exception_x = (debug_exception_x ==  1'b1) || (non_debug_exception_x ==  1'b1);
always @(*)
begin
    if (reset_exception ==  1'b1)
        eid_x =  3'h0;
    else
         if (data_bus_error_exception ==  1'b1)
        eid_x =  3'h4;
    else
         if (breakpoint_exception ==  1'b1)
        eid_x =  3'd1;
    else
         if (data_bus_error_exception ==  1'b1)
        eid_x =  3'h4;
    else
         if (instruction_bus_error_exception ==  1'b1)
        eid_x =  3'h2;
    else
         if (watchpoint_exception ==  1'b1)
        eid_x =  3'd3;
    else 
         if (divide_by_zero_exception ==  1'b1)
        eid_x =  3'h5;
    else
         if (   (interrupt_exception ==  1'b1)
             && (dc_ss ==  1'b0)
            )
        eid_x =  3'h6;
    else
        eid_x =  3'h7;
end
assign stall_a = (stall_f ==  1'b1);
assign stall_f = (stall_d ==  1'b1);
assign stall_d =   (stall_x ==  1'b1) 
                || (   (interlock ==  1'b1)
                    && (kill_d ==  1'b0)
                   ) 
		|| (   (   (eret_d ==  1'b1)
			|| (scall_d ==  1'b1)
			|| (bus_error_d ==  1'b1)
		       )
		    && (   (load_q_x ==  1'b1)
			|| (load_q_m ==  1'b1)
			|| (store_q_x ==  1'b1)
			|| (store_q_m ==  1'b1)
			|| (D_CYC_O ==  1'b1)
		       )
                    && (kill_d ==  1'b0)
		   )
		|| (   (   (break_d ==  1'b1)
			|| (bret_d ==  1'b1)
		       )
		    && (   (load_q_x ==  1'b1)
			|| (store_q_x ==  1'b1)
			|| (load_q_m ==  1'b1)
			|| (store_q_m ==  1'b1)
			|| (D_CYC_O ==  1'b1)
		       )
                    && (kill_d ==  1'b0)
		   )
                || (   (csr_write_enable_d ==  1'b1)
                    && (load_q_x ==  1'b1)
                   )                      
                ;
assign stall_x =    (stall_m ==  1'b1)
                 || (   (mc_stall_request_x ==  1'b1)
                     && (kill_x ==  1'b0)
                    ) 
                 ;
assign stall_m =    (stall_wb_load ==  1'b1)
                 || (   (D_CYC_O ==  1'b1)
                     && (   (store_m ==  1'b1)
		         || ((store_x ==  1'b1) && (interrupt_exception ==  1'b1))
                         || (load_m ==  1'b1)
                         || (load_x ==  1'b1)
                        ) 
                    ) 
                 || (dcache_stall_request ==  1'b1)     
                 || (icache_stall_request ==  1'b1)     
                 || ((I_CYC_O ==  1'b1) && ((branch_m ==  1'b1) || (exception_m ==  1'b1))) 
                 ;      
assign q_d = (valid_d ==  1'b1) && (kill_d ==  1'b0);
assign divide_q_d = (divide_d ==  1'b1) && (q_d ==  1'b1);
assign modulus_q_d = (modulus_d ==  1'b1) && (q_d ==  1'b1);
assign q_x = (valid_x ==  1'b1) && (kill_x ==  1'b0);
assign csr_write_enable_q_x = (csr_write_enable_x ==  1'b1) && (q_x ==  1'b1);
assign eret_q_x = (eret_x ==  1'b1) && (q_x ==  1'b1);
assign bret_q_x = (bret_x ==  1'b1) && (q_x ==  1'b1);
assign load_q_x = (load_x ==  1'b1) 
               && (q_x ==  1'b1)
               && (bp_match ==  1'b0)
                  ;
assign store_q_x = (store_x ==  1'b1) 
               && (q_x ==  1'b1)
               && (bp_match ==  1'b0)
                  ;
assign q_m = (valid_m ==  1'b1) && (kill_m ==  1'b0) && (exception_m ==  1'b0);
assign load_q_m = (load_m ==  1'b1) && (q_m ==  1'b1);
assign store_q_m = (store_m ==  1'b1) && (q_m ==  1'b1);
assign debug_exception_q_w = ((debug_exception_w ==  1'b1) && (valid_w ==  1'b1));
assign non_debug_exception_q_w = ((non_debug_exception_w ==  1'b1) && (valid_w ==  1'b1));        
assign write_enable_q_x = (write_enable_x ==  1'b1) && (valid_x ==  1'b1) && (branch_flushX_m ==  1'b0);
assign write_enable_q_m = (write_enable_m ==  1'b1) && (valid_m ==  1'b1);
assign write_enable_q_w = (write_enable_w ==  1'b1) && (valid_w ==  1'b1);
assign reg_write_enable_q_w = (write_enable_w ==  1'b1) && (kill_w ==  1'b0) && (valid_w ==  1'b1);
assign cfg = {
               6'h02,
              watchpoints[3:0],
              breakpoints[3:0],
              interrupts[5:0],
               1'b1,
               1'b0,
               1'b1,
               1'b1,
               1'b1,
               1'b1,
               1'b0,
               1'b0,
               1'b1,
               1'b1,
               1'b1,
               1'b1
              };
assign cfg2 = {
		     30'b0,
		      1'b0,
		      1'b0
		     };
assign iflush = (   (csr_write_enable_d ==  1'b1) 
                 && (csr_d ==  5'h3)
                 && (stall_d ==  1'b0)
                 && (kill_d ==  1'b0)
                 && (valid_d ==  1'b1))
             ||
                (   (jtag_csr_write_enable ==  1'b1)
		 && (jtag_csr ==  5'h3))
		 ;
assign dflush_x = (   (csr_write_enable_q_x ==  1'b1) 
                   && (csr_x ==  5'h4))
               ||
                  (   (jtag_csr_write_enable ==  1'b1)
		   && (jtag_csr ==  5'h4))
		   ;
assign csr_d = read_idx_0_d[ (5-1):0];
always @(*)
begin
    case (csr_x)
     5'h0,
     5'h1,
     5'h2:   csr_read_data_x = interrupt_csr_read_data_x;  
     5'h6:  csr_read_data_x = cfg;
     5'h7:  csr_read_data_x = {eba, 8'h00};
     5'h9: csr_read_data_x = {deba, 8'h00};
     5'he:  csr_read_data_x = jtx_csr_read_data;  
     5'hf:  csr_read_data_x = jrx_csr_read_data;
     5'ha: csr_read_data_x = cfg2;
     5'hb:  csr_read_data_x = sdb_address;
    default:        csr_read_data_x = { 32{1'bx}};
    endcase
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        eba <= eba_reset[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    else
    begin
        if ((csr_write_enable_q_x ==  1'b1) && (csr_x ==  5'h7) && (stall_x ==  1'b0))
            eba <= operand_1_x[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
        if ((jtag_csr_write_enable ==  1'b1) && (jtag_csr ==  5'h7))
            eba <= jtag_csr_write_data[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        deba <= deba_reset[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    else
    begin
        if ((csr_write_enable_q_x ==  1'b1) && (csr_x ==  5'h9) && (stall_x ==  1'b0))
            deba <= operand_1_x[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
        if ((jtag_csr_write_enable ==  1'b1) && (jtag_csr ==  5'h9))
            deba <= jtag_csr_write_data[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        data_bus_error_seen <=  1'b0;
    else
    begin
        if ((D_ERR_I ==  1'b1) && (D_CYC_O ==  1'b1))
            data_bus_error_seen <=  1'b1;
        if ((exception_m ==  1'b1) && (kill_m ==  1'b0))
            data_bus_error_seen <=  1'b0;
    end
end
always @(*)
begin
    if (   (icache_refill_request ==  1'b1) 
        || (dcache_refill_request ==  1'b1)
       )
        valid_a =  1'b0;
    else if (   (icache_restart_request ==  1'b1) 
             || (dcache_restart_request ==  1'b1) 
            ) 
        valid_a =  1'b1;
    else 
        valid_a = !icache_refilling && !dcache_refilling;
end 
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        valid_f <=  1'b0;
        valid_d <=  1'b0;
        valid_x <=  1'b0;
        valid_m <=  1'b0;
        valid_w <=  1'b0;
    end
    else
    begin    
        if ((kill_f ==  1'b1) || (stall_a ==  1'b0))
            valid_f <= valid_a;    
        else if (stall_f ==  1'b0)
            valid_f <=  1'b0;            
        if (kill_d ==  1'b1)
            valid_d <=  1'b0;
        else if (stall_f ==  1'b0)
            valid_d <= valid_f & !kill_f;
        else if (stall_d ==  1'b0)
            valid_d <=  1'b0;
        if (stall_d ==  1'b0)
            valid_x <= valid_d & !kill_d;
        else if (kill_x ==  1'b1)
            valid_x <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_x <=  1'b0;
        if (kill_m ==  1'b1)
            valid_m <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_m <= valid_x & !kill_x;
        else if (stall_m ==  1'b0)
            valid_m <=  1'b0;
        if (stall_m ==  1'b0)
            valid_w <= valid_m & !kill_m;
        else 
            valid_w <=  1'b0;        
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        operand_0_x <= { 32{1'b0}};
        operand_1_x <= { 32{1'b0}};
        store_operand_x <= { 32{1'b0}};
        branch_target_x <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};        
        x_result_sel_csr_x <=  1'b0;
        x_result_sel_mc_arith_x <=  1'b0;
        x_result_sel_sext_x <=  1'b0;
        x_result_sel_add_x <=  1'b0;
        m_result_sel_compare_x <=  1'b0;
        m_result_sel_shift_x <=  1'b0;
        w_result_sel_load_x <=  1'b0;
        w_result_sel_mul_x <=  1'b0;
        x_bypass_enable_x <=  1'b0;
        m_bypass_enable_x <=  1'b0;
        write_enable_x <=  1'b0;
        write_idx_x <= { 5{1'b0}};
        csr_x <= { 5{1'b0}};
        load_x <=  1'b0;
        store_x <=  1'b0;
        size_x <= { 2{1'b0}};
        sign_extend_x <=  1'b0;
        adder_op_x <=  1'b0;
        adder_op_x_n <=  1'b0;
        logic_op_x <= 4'h0;
        direction_x <=  1'b0;
        branch_x <=  1'b0;
        branch_predict_x <=  1'b0;
        branch_predict_taken_x <=  1'b0;
        condition_x <=  3'b000;
        break_x <=  1'b0;
        scall_x <=  1'b0;
        eret_x <=  1'b0;
        bret_x <=  1'b0;
        bus_error_x <=  1'b0;
        data_bus_error_exception_m <=  1'b0;
        csr_write_enable_x <=  1'b0;
        operand_m <= { 32{1'b0}};
        branch_target_m <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        m_result_sel_compare_m <=  1'b0;
        m_result_sel_shift_m <=  1'b0;
        w_result_sel_load_m <=  1'b0;
        w_result_sel_mul_m <=  1'b0;
        m_bypass_enable_m <=  1'b0;
        branch_m <=  1'b0;
        branch_predict_m <=  1'b0;
	branch_predict_taken_m <=  1'b0;
        exception_m <=  1'b0;
        load_m <=  1'b0;
        store_m <=  1'b0;
        write_enable_m <=  1'b0;            
        write_idx_m <= { 5{1'b0}};
        condition_met_m <=  1'b0;
        dflush_m <=  1'b0;
        debug_exception_m <=  1'b0;
        non_debug_exception_m <=  1'b0;        
        operand_w <= { 32{1'b0}};        
        w_result_sel_load_w <=  1'b0;
        w_result_sel_mul_w <=  1'b0;
        write_idx_w <= { 5{1'b0}};        
        write_enable_w <=  1'b0;
        debug_exception_w <=  1'b0;
        non_debug_exception_w <=  1'b0;        
        memop_pc_w <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
    end
    else
    begin
        if (stall_x ==  1'b0)
        begin
            operand_0_x <= d_result_0;
            operand_1_x <= d_result_1;
            store_operand_x <= bypass_data_1;
            branch_target_x <= branch_reg_d ==  1'b1 ? bypass_data_0[ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] : branch_target_d;            
            x_result_sel_csr_x <= x_result_sel_csr_d;
            x_result_sel_mc_arith_x <= x_result_sel_mc_arith_d;
            x_result_sel_sext_x <= x_result_sel_sext_d;
            x_result_sel_add_x <= x_result_sel_add_d;
            m_result_sel_compare_x <= m_result_sel_compare_d;
            m_result_sel_shift_x <= m_result_sel_shift_d;
            w_result_sel_load_x <= w_result_sel_load_d;
            w_result_sel_mul_x <= w_result_sel_mul_d;
            x_bypass_enable_x <= x_bypass_enable_d;
            m_bypass_enable_x <= m_bypass_enable_d;
            load_x <= load_d;
            store_x <= store_d;
            branch_x <= branch_d;
	    branch_predict_x <= branch_predict_d;
	    branch_predict_taken_x <= branch_predict_taken_d;
	    write_idx_x <= write_idx_d;
            csr_x <= csr_d;
            size_x <= size_d;
            sign_extend_x <= sign_extend_d;
            adder_op_x <= adder_op_d;
            adder_op_x_n <= ~adder_op_d;
            logic_op_x <= logic_op_d;
            direction_x <= direction_d;
            condition_x <= condition_d;
            csr_write_enable_x <= csr_write_enable_d;
            break_x <= break_d;
            scall_x <= scall_d;
            bus_error_x <= bus_error_d;
            eret_x <= eret_d;
            bret_x <= bret_d; 
            write_enable_x <= write_enable_d;
        end
        if (stall_m ==  1'b0)
        begin
            operand_m <= x_result;
            m_result_sel_compare_m <= m_result_sel_compare_x;
            m_result_sel_shift_m <= m_result_sel_shift_x;
            if (exception_x ==  1'b1)
            begin
                w_result_sel_load_m <=  1'b0;
                w_result_sel_mul_m <=  1'b0;
            end
            else
            begin
                w_result_sel_load_m <= w_result_sel_load_x;
                w_result_sel_mul_m <= w_result_sel_mul_x;
            end
            m_bypass_enable_m <= m_bypass_enable_x;
            load_m <= load_x;
            store_m <= store_x;
            branch_m <= branch_x && !branch_taken_x;
            if (non_debug_exception_x ==  1'b1) 
                write_idx_m <=  5'd30;
            else if (debug_exception_x ==  1'b1)
                write_idx_m <=  5'd31;
            else 
                write_idx_m <= write_idx_x;
            condition_met_m <= condition_met_x;
	   if (exception_x ==  1'b1)
	     if ((dc_re ==  1'b1)
		 || ((debug_exception_x ==  1'b1) 
		     && (non_debug_exception_x ==  1'b0)))
	       branch_target_m <= {deba, eid_x, {3{1'b0}}};
	     else
	       branch_target_m <= {eba, eid_x, {3{1'b0}}};
	   else
	     branch_target_m <= branch_target_x;
            dflush_m <= dflush_x;
            write_enable_m <= exception_x ==  1'b1 ?  1'b1 : write_enable_x;            
            debug_exception_m <= debug_exception_x;
            non_debug_exception_m <= non_debug_exception_x;        
        end
        if (stall_m ==  1'b0)
        begin
            if ((exception_x ==  1'b1) && (q_x ==  1'b1) && (stall_x ==  1'b0))
                exception_m <=  1'b1;
            else 
                exception_m <=  1'b0;
	   data_bus_error_exception_m <=    (data_bus_error_exception ==  1'b1) 
					 && (reset_exception ==  1'b0)
					 ;
	end
        operand_w <= exception_m ==  1'b1 ? (data_bus_error_exception_m ? {memop_pc_w, 2'b00} : {pc_m, 2'b00}) : m_result;
        w_result_sel_load_w <= w_result_sel_load_m;
        w_result_sel_mul_w <= w_result_sel_mul_m;
        write_idx_w <= write_idx_m;
        write_enable_w <= write_enable_m;
        debug_exception_w <= debug_exception_m;
        non_debug_exception_w <= non_debug_exception_m;
        if (   (stall_m ==  1'b0)
            && (   (load_q_m ==  1'b1) 
                || (store_q_m ==  1'b1)
               )
	   )
          memop_pc_w <= pc_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        use_buf <=  1'b0;
        reg_data_buf_0 <= { 32{1'b0}};
        reg_data_buf_1 <= { 32{1'b0}};
    end
    else
    begin
        if (stall_d ==  1'b0)
            use_buf <=  1'b0;
        else if (use_buf ==  1'b0)
        begin        
            reg_data_buf_0 <= reg_data_live_0;
            reg_data_buf_1 <= reg_data_live_1;
            use_buf <=  1'b1;
        end        
        if (reg_write_enable_q_w ==  1'b1)
        begin
            if (write_idx_w == read_idx_0_d)
                reg_data_buf_0 <= w_result;
            if (write_idx_w == read_idx_1_d)
                reg_data_buf_1 <= w_result;
        end
    end
end
initial
begin
end
endmodule 
module lm32_load_store_unit_full_debug (
    clk_i,
    rst_i,
    stall_a,
    stall_x,
    stall_m,
    kill_x,
    kill_m,
    exception_m,
    store_operand_x,
    load_store_address_x,
    load_store_address_m,
    load_store_address_w,
    load_x,
    store_x,
    load_q_x,
    store_q_x,
    load_q_m,
    store_q_m,
    sign_extend_x,
    size_x,
    dflush,
    d_dat_i,
    d_ack_i,
    d_err_i,
    d_rty_i,
    dcache_refill_request,
    dcache_restart_request,
    dcache_stall_request,
    dcache_refilling,
    load_data_w,
    stall_wb_load,
    d_dat_o,
    d_adr_o,
    d_cyc_o,
    d_sel_o,
    d_stb_o,
    d_we_o,
    d_cti_o,
    d_lock_o,
    d_bte_o
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_x;                                          
input stall_m;                                          
input kill_x;                                           
input kill_m;                                           
input exception_m;                                      
input [ (32-1):0] store_operand_x;                 
input [ (32-1):0] load_store_address_x;            
input [ (32-1):0] load_store_address_m;            
input [1:0] load_store_address_w;                       
input load_x;                                           
input store_x;                                          
input load_q_x;                                         
input store_q_x;                                        
input load_q_m;                                         
input store_q_m;                                        
input sign_extend_x;                                    
input [ 1:0] size_x;                          
input dflush;                                           
input [ (32-1):0] d_dat_i;                         
input d_ack_i;                                          
input d_err_i;                                          
input d_rty_i;                                          
output dcache_refill_request;                           
wire   dcache_refill_request;
output dcache_restart_request;                          
wire   dcache_restart_request;
output dcache_stall_request;                            
wire   dcache_stall_request;
output dcache_refilling;
wire   dcache_refilling;
output [ (32-1):0] load_data_w;                    
reg    [ (32-1):0] load_data_w;
output stall_wb_load;                                   
reg    stall_wb_load;
output [ (32-1):0] d_dat_o;                        
reg    [ (32-1):0] d_dat_o;
output [ (32-1):0] d_adr_o;                        
reg    [ (32-1):0] d_adr_o;
output d_cyc_o;                                         
reg    d_cyc_o;
output [ (4-1):0] d_sel_o;                 
reg    [ (4-1):0] d_sel_o;
output d_stb_o;                                         
reg    d_stb_o; 
output d_we_o;                                          
reg    d_we_o;
output [ (3-1):0] d_cti_o;                       
reg    [ (3-1):0] d_cti_o;
output d_lock_o;                                        
reg    d_lock_o;
output [ (2-1):0] d_bte_o;                       
wire   [ (2-1):0] d_bte_o;
reg [ 1:0] size_m;
reg [ 1:0] size_w;
reg sign_extend_m;
reg sign_extend_w;
reg [ (32-1):0] store_data_x;       
reg [ (32-1):0] store_data_m;       
reg [ (4-1):0] byte_enable_x;
reg [ (4-1):0] byte_enable_m;
wire [ (32-1):0] data_m;
reg [ (32-1):0] data_w;
wire dcache_select_x;                                   
reg dcache_select_m;
wire [ (32-1):0] dcache_data_m;                    
wire [ (32-1):0] dcache_refill_address;            
reg dcache_refill_ready;                                
wire [ (3-1):0] first_cycle_type;                
wire [ (3-1):0] next_cycle_type;                 
wire last_word;                                         
wire [ (32-1):0] first_address;                    
wire wb_select_x;                                       
reg wb_select_m;
reg [ (32-1):0] wb_data_m;                         
reg wb_load_complete;                                   
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_dcache_full_debug #(
    .associativity          (associativity),
    .sets                   (sets),
    .bytes_per_line         (bytes_per_line),
    .base_address           (base_address),
    .limit                  (limit)
    ) dcache ( 
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),      
    .stall_a                (stall_a),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .address_x              (load_store_address_x),
    .address_m              (load_store_address_m),
    .load_q_m               (load_q_m & dcache_select_m),
    .store_q_m              (store_q_m & dcache_select_m),
    .store_data             (store_data_m),
    .store_byte_select      (byte_enable_m & {4{dcache_select_m}}),
    .refill_ready           (dcache_refill_ready),
    .refill_data            (wb_data_m),
    .dflush                 (dflush),
    .stall_request          (dcache_stall_request),
    .restart_request        (dcache_restart_request),
    .refill_request         (dcache_refill_request),
    .refill_address         (dcache_refill_address),
    .refilling              (dcache_refilling),
    .load_data              (dcache_data_m)
    );
   assign dcache_select_x =    (load_store_address_x >=  32'h0) 
                            && (load_store_address_x <=  32'h7fffffff)
                     ;
   assign wb_select_x =     1'b1
                        && !dcache_select_x 
                     ;
always @(*)
begin
    case (size_x)
     2'b00:  store_data_x = {4{store_operand_x[7:0]}};
     2'b11: store_data_x = {2{store_operand_x[15:0]}};
     2'b10:  store_data_x = store_operand_x;    
    default:          store_data_x = { 32{1'bx}};
    endcase
end
always @(*)
begin
    casez ({size_x, load_store_address_x[1:0]})
    { 2'b00, 2'b11}:  byte_enable_x = 4'b0001;
    { 2'b00, 2'b10}:  byte_enable_x = 4'b0010;
    { 2'b00, 2'b01}:  byte_enable_x = 4'b0100;
    { 2'b00, 2'b00}:  byte_enable_x = 4'b1000;
    { 2'b11, 2'b1?}: byte_enable_x = 4'b0011;
    { 2'b11, 2'b0?}: byte_enable_x = 4'b1100;
    { 2'b10, 2'b??}:  byte_enable_x = 4'b1111;
    default:                   byte_enable_x = 4'bxxxx;
    endcase
end
   assign data_m = wb_select_m ==  1'b1 
                   ? wb_data_m 
                   : dcache_data_m;
always @(*)
begin
    casez ({size_w, load_store_address_w[1:0]})
    { 2'b00, 2'b11}:  load_data_w = {{24{sign_extend_w & data_w[7]}}, data_w[7:0]};
    { 2'b00, 2'b10}:  load_data_w = {{24{sign_extend_w & data_w[15]}}, data_w[15:8]};
    { 2'b00, 2'b01}:  load_data_w = {{24{sign_extend_w & data_w[23]}}, data_w[23:16]};
    { 2'b00, 2'b00}:  load_data_w = {{24{sign_extend_w & data_w[31]}}, data_w[31:24]};
    { 2'b11, 2'b1?}: load_data_w = {{16{sign_extend_w & data_w[15]}}, data_w[15:0]};
    { 2'b11, 2'b0?}: load_data_w = {{16{sign_extend_w & data_w[31]}}, data_w[31:16]};
    { 2'b10, 2'b??}:  load_data_w = data_w;
    default:                   load_data_w = { 32{1'bx}};
    endcase
end
assign d_bte_o =  2'b00;
generate 
    case (bytes_per_line)
    4:
    begin
assign first_cycle_type =  3'b111;
assign next_cycle_type =  3'b111;
assign last_word =  1'b1;
assign first_address = {dcache_refill_address[ 32-1:2], 2'b00};
    end
    8:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type =  3'b111;
assign last_word = (&d_adr_o[addr_offset_msb:addr_offset_lsb]) == 1'b1;
assign first_address = {dcache_refill_address[ 32-1:addr_offset_msb+1], {addr_offset_width{1'b0}}, 2'b00};
    end
    16:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type = d_adr_o[addr_offset_msb] == 1'b1 ?  3'b111 :  3'b010;
assign last_word = (&d_adr_o[addr_offset_msb:addr_offset_lsb]) == 1'b1;
assign first_address = {dcache_refill_address[ 32-1:addr_offset_msb+1], {addr_offset_width{1'b0}}, 2'b00};
    end
    endcase
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        d_cyc_o <=  1'b0;
        d_stb_o <=  1'b0;
        d_dat_o <= { 32{1'b0}};
        d_adr_o <= { 32{1'b0}};
        d_sel_o <= { 4{ 1'b0}};
        d_we_o <=  1'b0;
        d_cti_o <=  3'b111;
        d_lock_o <=  1'b0;
        wb_data_m <= { 32{1'b0}};
        wb_load_complete <=  1'b0;
        stall_wb_load <=  1'b0;
        dcache_refill_ready <=  1'b0;
    end
    else
    begin
        dcache_refill_ready <=  1'b0;
        if (d_cyc_o ==  1'b1)
        begin
            if ((d_ack_i ==  1'b1) || (d_err_i ==  1'b1))
            begin
                if ((dcache_refilling ==  1'b1) && (!last_word))
                begin
                    d_adr_o[addr_offset_msb:addr_offset_lsb] <= d_adr_o[addr_offset_msb:addr_offset_lsb] + 1'b1;
                end
                else
                begin
                    d_cyc_o <=  1'b0;
                    d_stb_o <=  1'b0;
                    d_lock_o <=  1'b0;
                end
                d_cti_o <= next_cycle_type;
                dcache_refill_ready <= dcache_refilling;
                wb_data_m <= d_dat_i;
                wb_load_complete <= !d_we_o;
            end
            if (d_err_i ==  1'b1)
                $display ("Data bus error. Address: %x", d_adr_o);
        end
        else
        begin
            if (dcache_refill_request ==  1'b1)
            begin
                d_adr_o <= first_address;
                d_cyc_o <=  1'b1;
                d_sel_o <= { 32/8{ 1'b1}};
                d_stb_o <=  1'b1;                
                d_we_o <=  1'b0;
                d_cti_o <= first_cycle_type;
            end
            else 
                 if (   (store_q_m ==  1'b1)
                     && (stall_m ==  1'b0)
                    )
            begin
                d_dat_o <= store_data_m;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b1;
                d_cti_o <=  3'b111;
            end        
            else if (   (load_q_m ==  1'b1) 
                     && (wb_select_m ==  1'b1) 
                     && (wb_load_complete ==  1'b0)
                    )
            begin
                stall_wb_load <=  1'b0;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b0;
                d_cti_o <=  3'b111;
            end
        end
        if (stall_m ==  1'b0)
            wb_load_complete <=  1'b0;
        if ((load_q_x ==  1'b1) && (wb_select_x ==  1'b1) && (stall_x ==  1'b0))
            stall_wb_load <=  1'b1;
        if ((kill_m ==  1'b1) || (exception_m ==  1'b1))
            stall_wb_load <=  1'b0;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        sign_extend_m <=  1'b0;
        size_m <= 2'b00;
        byte_enable_m <=  1'b0;
        store_data_m <= { 32{1'b0}};
        dcache_select_m <=  1'b0;
        wb_select_m <=  1'b0;        
    end
    else
    begin
        if (stall_m ==  1'b0)
        begin
            sign_extend_m <= sign_extend_x;
            size_m <= size_x;
            byte_enable_m <= byte_enable_x;    
            store_data_m <= store_data_x;
            dcache_select_m <= dcache_select_x;
            wb_select_m <= wb_select_x;
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        size_w <= 2'b00;
        data_w <= { 32{1'b0}};
        sign_extend_w <=  1'b0;
    end
    else
    begin
        size_w <= size_m;
        data_w <= data_m;
        sign_extend_w <= sign_extend_m;
    end
end
always @(posedge clk_i)
begin
    if (((load_q_m ==  1'b1) || (store_q_m ==  1'b1)) && (stall_m ==  1'b0)) 
    begin
        if ((size_m ===  2'b11) && (load_store_address_m[0] !== 1'b0))
            $display ("Warning: Non-aligned halfword access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
        if ((size_m ===  2'b10) && (load_store_address_m[1:0] !== 2'b00))
            $display ("Warning: Non-aligned word access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
    end
end
endmodule
module lm32_decoder_full_debug (
    instruction,
    d_result_sel_0,
    d_result_sel_1,        
    x_result_sel_csr,
    x_result_sel_mc_arith,
    x_result_sel_sext,
    x_result_sel_logic,
    x_result_sel_add,
    m_result_sel_compare,
    m_result_sel_shift,  
    w_result_sel_load,
    w_result_sel_mul,
    x_bypass_enable,
    m_bypass_enable,
    read_enable_0,
    read_idx_0,
    read_enable_1,
    read_idx_1,
    write_enable,
    write_idx,
    immediate,
    branch_offset,
    load,
    store,
    size,
    sign_extend,
    adder_op,
    logic_op,
    direction,
    divide,
    modulus,
    branch,
    branch_reg,
    condition,
    bi_conditional,
    bi_unconditional,
    break_opcode,
    scall,
    eret,
    bret,
    csr_write_enable
    );
input [ (32-1):0] instruction;       
output [ 0:0] d_result_sel_0;
reg    [ 0:0] d_result_sel_0;
output [ 1:0] d_result_sel_1;
reg    [ 1:0] d_result_sel_1;
output x_result_sel_csr;
reg    x_result_sel_csr;
output x_result_sel_mc_arith;
reg    x_result_sel_mc_arith;
output x_result_sel_sext;
reg    x_result_sel_sext;
output x_result_sel_logic;
reg    x_result_sel_logic;
output x_result_sel_add;
reg    x_result_sel_add;
output m_result_sel_compare;
reg    m_result_sel_compare;
output m_result_sel_shift;
reg    m_result_sel_shift;
output w_result_sel_load;
reg    w_result_sel_load;
output w_result_sel_mul;
reg    w_result_sel_mul;
output x_bypass_enable;
wire   x_bypass_enable;
output m_bypass_enable;
wire   m_bypass_enable;
output read_enable_0;
wire   read_enable_0;
output [ (5-1):0] read_idx_0;
wire   [ (5-1):0] read_idx_0;
output read_enable_1;
wire   read_enable_1;
output [ (5-1):0] read_idx_1;
wire   [ (5-1):0] read_idx_1;
output write_enable;
wire   write_enable;
output [ (5-1):0] write_idx;
wire   [ (5-1):0] write_idx;
output [ (32-1):0] immediate;
wire   [ (32-1):0] immediate;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset;
wire   [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset;
output load;
wire   load;
output store;
wire   store;
output [ 1:0] size;
wire   [ 1:0] size;
output sign_extend;
wire   sign_extend;
output adder_op;
wire   adder_op;
output [ 3:0] logic_op;
wire   [ 3:0] logic_op;
output direction;
wire   direction;
output divide;
wire   divide;
output modulus;
wire   modulus;
output branch;
wire   branch;
output branch_reg;
wire   branch_reg;
output [ (3-1):0] condition;
wire   [ (3-1):0] condition;
output bi_conditional;
wire bi_conditional;
output bi_unconditional;
wire bi_unconditional;
output break_opcode;
wire   break_opcode;
output scall;
wire   scall;
output eret;
wire   eret;
output bret;
wire   bret;
output csr_write_enable;
wire   csr_write_enable;
wire [ (32-1):0] extended_immediate;       
wire [ (32-1):0] high_immediate;           
wire [ (32-1):0] call_immediate;           
wire [ (32-1):0] branch_immediate;         
wire sign_extend_immediate;                     
wire select_high_immediate;                     
wire select_call_immediate;                     
wire op_add;
wire op_and;
wire op_andhi;
wire op_b;
wire op_bi;
wire op_be;
wire op_bg;
wire op_bge;
wire op_bgeu;
wire op_bgu;
wire op_bne;
wire op_call;
wire op_calli;
wire op_cmpe;
wire op_cmpg;
wire op_cmpge;
wire op_cmpgeu;
wire op_cmpgu;
wire op_cmpne;
wire op_divu;
wire op_lb;
wire op_lbu;
wire op_lh;
wire op_lhu;
wire op_lw;
wire op_modu;
wire op_mul;
wire op_nor;
wire op_or;
wire op_orhi;
wire op_raise;
wire op_rcsr;
wire op_sb;
wire op_sextb;
wire op_sexth;
wire op_sh;
wire op_sl;
wire op_sr;
wire op_sru;
wire op_sub;
wire op_sw;
wire op_wcsr;
wire op_xnor;
wire op_xor;
wire arith;
wire logical;
wire cmp;
wire bra;
wire call;
wire shift;
wire sext;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
assign op_add    = instruction[ 30:26] ==  5'b01101;
assign op_and    = instruction[ 30:26] ==  5'b01000;
assign op_andhi  = instruction[ 31:26] ==  6'b011000;
assign op_b      = instruction[ 31:26] ==  6'b110000;
assign op_bi     = instruction[ 31:26] ==  6'b111000;
assign op_be     = instruction[ 31:26] ==  6'b010001;
assign op_bg     = instruction[ 31:26] ==  6'b010010;
assign op_bge    = instruction[ 31:26] ==  6'b010011;
assign op_bgeu   = instruction[ 31:26] ==  6'b010100;
assign op_bgu    = instruction[ 31:26] ==  6'b010101;
assign op_bne    = instruction[ 31:26] ==  6'b010111;
assign op_call   = instruction[ 31:26] ==  6'b110110;
assign op_calli  = instruction[ 31:26] ==  6'b111110;
assign op_cmpe   = instruction[ 30:26] ==  5'b11001;
assign op_cmpg   = instruction[ 30:26] ==  5'b11010;
assign op_cmpge  = instruction[ 30:26] ==  5'b11011;
assign op_cmpgeu = instruction[ 30:26] ==  5'b11100;
assign op_cmpgu  = instruction[ 30:26] ==  5'b11101;
assign op_cmpne  = instruction[ 30:26] ==  5'b11111;
assign op_divu   = instruction[ 31:26] ==  6'b100011;
assign op_lb     = instruction[ 31:26] ==  6'b000100;
assign op_lbu    = instruction[ 31:26] ==  6'b010000;
assign op_lh     = instruction[ 31:26] ==  6'b000111;
assign op_lhu    = instruction[ 31:26] ==  6'b001011;
assign op_lw     = instruction[ 31:26] ==  6'b001010;
assign op_modu   = instruction[ 31:26] ==  6'b110001;
assign op_mul    = instruction[ 30:26] ==  5'b00010;
assign op_nor    = instruction[ 30:26] ==  5'b00001;
assign op_or     = instruction[ 30:26] ==  5'b01110;
assign op_orhi   = instruction[ 31:26] ==  6'b011110;
assign op_raise  = instruction[ 31:26] ==  6'b101011;
assign op_rcsr   = instruction[ 31:26] ==  6'b100100;
assign op_sb     = instruction[ 31:26] ==  6'b001100;
assign op_sextb  = instruction[ 31:26] ==  6'b101100;
assign op_sexth  = instruction[ 31:26] ==  6'b110111;
assign op_sh     = instruction[ 31:26] ==  6'b000011;
assign op_sl     = instruction[ 30:26] ==  5'b01111;      
assign op_sr     = instruction[ 30:26] ==  5'b00101;
assign op_sru    = instruction[ 30:26] ==  5'b00000;
assign op_sub    = instruction[ 31:26] ==  6'b110010;
assign op_sw     = instruction[ 31:26] ==  6'b010110;
assign op_wcsr   = instruction[ 31:26] ==  6'b110100;
assign op_xnor   = instruction[ 30:26] ==  5'b01001;
assign op_xor    = instruction[ 30:26] ==  5'b00110;
assign arith = op_add | op_sub;
assign logical = op_and | op_andhi | op_nor | op_or | op_orhi | op_xor | op_xnor;
assign cmp = op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne;
assign bi_conditional = op_be | op_bg | op_bge | op_bgeu  | op_bgu | op_bne;
assign bi_unconditional = op_bi;
assign bra = op_b | bi_unconditional | bi_conditional;
assign call = op_call | op_calli;
assign shift = op_sl | op_sr | op_sru;
assign sext = op_sextb | op_sexth;
assign divide = op_divu; 
assign modulus = op_modu;
assign load = op_lb | op_lbu | op_lh | op_lhu | op_lw;
assign store = op_sb | op_sh | op_sw;
always @(*)
begin
    if (call) 
        d_result_sel_0 =  1'b1;
    else 
        d_result_sel_0 =  1'b0;
    if (call) 
        d_result_sel_1 =  2'b00;         
    else if ((instruction[31] == 1'b0) && !bra) 
        d_result_sel_1 =  2'b10;
    else
        d_result_sel_1 =  2'b01; 
    x_result_sel_csr =  1'b0;
    x_result_sel_mc_arith =  1'b0;
    x_result_sel_sext =  1'b0;
    x_result_sel_logic =  1'b0;
    x_result_sel_add =  1'b0;
    if (op_rcsr)
        x_result_sel_csr =  1'b1;
    else if (divide | modulus)
        x_result_sel_mc_arith =  1'b1;        
    else if (sext)
        x_result_sel_sext =  1'b1;
    else if (logical) 
        x_result_sel_logic =  1'b1;
    else 
        x_result_sel_add =  1'b1;        
    m_result_sel_compare = cmp;
    m_result_sel_shift = shift;
    w_result_sel_load = load;
    w_result_sel_mul = op_mul; 
end
assign x_bypass_enable =  arith 
                        | logical
                        | divide
                        | modulus
                        | sext 
                        | op_rcsr
                        ;
assign m_bypass_enable = x_bypass_enable 
                        | shift
                        | cmp
                        ;
assign read_enable_0 = ~(op_bi | op_calli);
assign read_idx_0 = instruction[25:21];
assign read_enable_1 = ~(op_bi | op_calli | load);
assign read_idx_1 = instruction[20:16];
assign write_enable = ~(bra | op_raise | store | op_wcsr);
assign write_idx = call
                    ? 5'd29
                    : instruction[31] == 1'b0 
                        ? instruction[20:16] 
                        : instruction[15:11];
assign size = instruction[27:26];
assign sign_extend = instruction[28];                      
assign adder_op = op_sub | op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne | bra;
assign logic_op = instruction[29:26];
assign direction = instruction[29];
assign branch = bra | call;
assign branch_reg = op_call | op_b;
assign condition = instruction[28:26];      
assign break_opcode = op_raise & ~instruction[2];
assign scall = op_raise & instruction[2];
assign eret = op_b & (instruction[25:21] == 5'd30);
assign bret = op_b & (instruction[25:21] == 5'd31);
assign csr_write_enable = op_wcsr;
assign sign_extend_immediate = ~(op_and | op_cmpgeu | op_cmpgu | op_nor | op_or | op_xnor | op_xor);
assign select_high_immediate = op_andhi | op_orhi;
assign select_call_immediate = instruction[31];
assign high_immediate = {instruction[15:0], 16'h0000};
assign extended_immediate = {{16{sign_extend_immediate & instruction[15]}}, instruction[15:0]};
assign call_immediate = {{6{instruction[25]}}, instruction[25:0]};
assign branch_immediate = {{16{instruction[15]}}, instruction[15:0]};
assign immediate = select_high_immediate ==  1'b1 
                        ? high_immediate 
                        : extended_immediate;
assign branch_offset = select_call_immediate ==  1'b1   
                        ? (call_immediate[ (clogb2(32'h7fffffff-32'h0)-2)-1:0])
                        : (branch_immediate[ (clogb2(32'h7fffffff-32'h0)-2)-1:0]);
endmodule 
module lm32_icache_full_debug ( 
    clk_i,
    rst_i,    
    stall_a,
    stall_f,
    address_a,
    address_f,
    read_enable_f,
    refill_ready,
    refill_data,
    iflush,
    valid_d,
    branch_predict_taken_d,
    stall_request,
    restart_request,
    refill_request,
    refill_address,
    refilling,
    inst
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = clogb2(bytes_per_line)-1-2;
localparam addr_set_width = clogb2(sets)-1;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
localparam addr_set_lsb = (addr_offset_msb+1);
localparam addr_set_msb = (addr_set_lsb+addr_set_width-1);
localparam addr_tag_lsb = (addr_set_msb+1);
localparam addr_tag_msb = clogb2( 32'h7fffffff- 32'h0)-1;
localparam addr_tag_width = (addr_tag_msb-addr_tag_lsb+1);
input clk_i;                                        
input rst_i;                                        
input stall_a;                                      
input stall_f;                                      
input valid_d;                                      
input branch_predict_taken_d;                       
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] address_a;                     
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] address_f;                     
input read_enable_f;                                
input refill_ready;                                 
input [ (32-1):0] refill_data;          
input iflush;                                       
output stall_request;                               
wire   stall_request;
output restart_request;                             
reg    restart_request;
output refill_request;                              
wire   refill_request;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] refill_address;               
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] refill_address;               
output refilling;                                   
reg    refilling;
output [ (32-1):0] inst;                
wire   [ (32-1):0] inst;
wire enable;
wire [0:associativity-1] way_mem_we;
wire [ (32-1):0] way_data[0:associativity-1];
wire [ ((addr_tag_width+1)-1):1] way_tag[0:associativity-1];
wire [0:associativity-1] way_valid;
wire [0:associativity-1] way_match;
wire miss;
wire [ (addr_set_width-1):0] tmem_read_address;
wire [ (addr_set_width-1):0] tmem_write_address;
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_read_address;
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_write_address;
wire [ ((addr_tag_width+1)-1):0] tmem_write_data;
reg [ 3:0] state;
wire flushing;
wire check;
wire refill;
reg [associativity-1:0] refill_way_select;
reg [ addr_offset_msb:addr_offset_lsb] refill_offset;
wire last_refill;
reg [ (addr_set_width-1):0] flush_set;
genvar i;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
   generate
      for (i = 0; i < associativity; i = i + 1)
	begin : memories
	   lm32_ram 
	     #(
	       .data_width                 (32),
	       .address_width              ( (addr_offset_width+addr_set_width))
) 
	   way_0_data_ram 
	     (
	      .read_clk                   (clk_i),
	      .write_clk                  (clk_i),
	      .reset                      (rst_i),
	      .read_address               (dmem_read_address),
	      .enable_read                (enable),
	      .write_address              (dmem_write_address),
	      .enable_write               ( 1'b1),
	      .write_enable               (way_mem_we[i]),
	      .write_data                 (refill_data),    
	      .read_data                  (way_data[i])
	      );
	   lm32_ram 
	     #(
	       .data_width                 ( (addr_tag_width+1)),
	       .address_width              ( addr_set_width)
	       ) 
	   way_0_tag_ram 
	     (
	      .read_clk                   (clk_i),
	      .write_clk                  (clk_i),
	      .reset                      (rst_i),
	      .read_address               (tmem_read_address),
	      .enable_read                (enable),
	      .write_address              (tmem_write_address),
	      .enable_write               ( 1'b1),
	      .write_enable               (way_mem_we[i] | flushing),
	      .write_data                 (tmem_write_data),
	      .read_data                  ({way_tag[i], way_valid[i]})
	      );
	end
endgenerate
generate
    for (i = 0; i < associativity; i = i + 1)
    begin : match
assign way_match[i] = ({way_tag[i], way_valid[i]} == {address_f[ addr_tag_msb:addr_tag_lsb],  1'b1});
    end
endgenerate
generate
    if (associativity == 1)
    begin : inst_1
assign inst = way_match[0] ? way_data[0] : 32'b0;
    end
    else if (associativity == 2)
	 begin : inst_2
assign inst = way_match[0] ? way_data[0] : (way_match[1] ? way_data[1] : 32'b0);
    end
endgenerate
generate 
    if (bytes_per_line > 4)
assign dmem_write_address = {refill_address[ addr_set_msb:addr_set_lsb], refill_offset};
    else
assign dmem_write_address = refill_address[ addr_set_msb:addr_set_lsb];
endgenerate
assign dmem_read_address = address_a[ addr_set_msb:addr_offset_lsb];
assign tmem_read_address = address_a[ addr_set_msb:addr_set_lsb];
assign tmem_write_address = flushing 
                                ? flush_set
                                : refill_address[ addr_set_msb:addr_set_lsb];
generate 
    if (bytes_per_line > 4)                            
assign last_refill = refill_offset == {addr_offset_width{1'b1}};
    else
assign last_refill =  1'b1;
endgenerate
assign enable = (stall_a ==  1'b0);
generate
    if (associativity == 1) 
    begin : we_1     
assign way_mem_we[0] = (refill_ready ==  1'b1);
    end
    else
    begin : we_2
assign way_mem_we[0] = (refill_ready ==  1'b1) && (refill_way_select[0] ==  1'b1);
assign way_mem_we[1] = (refill_ready ==  1'b1) && (refill_way_select[1] ==  1'b1);
    end
endgenerate                     
assign tmem_write_data[ 0] = last_refill & !flushing;
assign tmem_write_data[ ((addr_tag_width+1)-1):1] = refill_address[ addr_tag_msb:addr_tag_lsb];
assign flushing = |state[1:0];
assign check = state[2];
assign refill = state[3];
assign miss = (~(|way_match)) && (read_enable_f ==  1'b1) && (stall_f ==  1'b0) && !(valid_d && branch_predict_taken_d);
assign stall_request = (check ==  1'b0);
assign refill_request = (refill ==  1'b1);
generate
    if (associativity >= 2) 
    begin : way_select      
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_way_select <= {{associativity-1{1'b0}}, 1'b1};
    else
    begin        
        if (miss ==  1'b1)
            refill_way_select <= {refill_way_select[0], refill_way_select[1]};
    end
end
    end
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refilling <=  1'b0;
    else
        refilling <= refill;
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        state <=  4'b0001;
        flush_set <= { addr_set_width{1'b1}};
        refill_address <= { (clogb2(32'h7fffffff-32'h0)-2){1'bx}};
        restart_request <=  1'b0;
    end
    else 
    begin
        case (state)
         4'b0001:
        begin            
            if (flush_set == { addr_set_width{1'b0}})
                state <=  4'b0100;
            flush_set <= flush_set - 1'b1;
        end
         4'b0010:
        begin            
            if (flush_set == { addr_set_width{1'b0}})
		state <=  4'b0100;
            flush_set <= flush_set - 1'b1;
        end
         4'b0100:
        begin            
            if (stall_a ==  1'b0)
                restart_request <=  1'b0;
            if (iflush ==  1'b1)
            begin
                refill_address <= address_f;
                state <=  4'b0010;
            end
            else if (miss ==  1'b1)
            begin
                refill_address <= address_f;
                state <=  4'b1000;
            end
        end
         4'b1000:
        begin            
            if (refill_ready ==  1'b1)
            begin
                if (last_refill ==  1'b1)
                begin
                    restart_request <=  1'b1;
                    state <=  4'b0100;
                end
            end
        end
        endcase        
    end
end
generate 
    if (bytes_per_line > 4)
    begin
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_offset <= {addr_offset_width{1'b0}};
    else 
    begin
        case (state)
         4'b0100:
        begin            
            if (iflush ==  1'b1)
                refill_offset <= {addr_offset_width{1'b0}};
            else if (miss ==  1'b1)
                refill_offset <= {addr_offset_width{1'b0}};
        end
         4'b1000:
        begin            
            if (refill_ready ==  1'b1)
                refill_offset <= refill_offset + 1'b1;
        end
        endcase        
    end
end
    end
endgenerate
endmodule
module lm32_dcache_full_debug ( 
    clk_i,
    rst_i,    
    stall_a,
    stall_x,
    stall_m,
    address_x,
    address_m,
    load_q_m,
    store_q_m,
    store_data,
    store_byte_select,
    refill_ready,
    refill_data,
    dflush,
    stall_request,
    restart_request,
    refill_request,
    refill_address,
    refilling,
    load_data
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = clogb2(bytes_per_line)-1-2;
localparam addr_set_width = clogb2(sets)-1;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
localparam addr_set_lsb = (addr_offset_msb+1);
localparam addr_set_msb = (addr_set_lsb+addr_set_width-1);
localparam addr_tag_lsb = (addr_set_msb+1);
localparam addr_tag_msb = clogb2( 32'h7fffffff- 32'h0)-1;
localparam addr_tag_width = (addr_tag_msb-addr_tag_lsb+1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_x;                                          
input stall_m;                                          
input [ (32-1):0] address_x;                       
input [ (32-1):0] address_m;                       
input load_q_m;                                         
input store_q_m;                                        
input [ (32-1):0] store_data;                      
input [ (4-1):0] store_byte_select;        
input refill_ready;                                     
input [ (32-1):0] refill_data;                     
input dflush;                                           
output stall_request;                                   
wire   stall_request;
output restart_request;                                 
reg    restart_request;
output refill_request;                                  
reg    refill_request;
output [ (32-1):0] refill_address;                 
reg    [ (32-1):0] refill_address;
output refilling;                                       
reg    refilling;
output [ (32-1):0] load_data;                      
wire   [ (32-1):0] load_data;
wire read_port_enable;                                  
wire write_port_enable;                                 
wire [0:associativity-1] way_tmem_we;                   
wire [0:associativity-1] way_dmem_we;                   
wire [ (32-1):0] way_data[0:associativity-1];      
wire [ ((addr_tag_width+1)-1):1] way_tag[0:associativity-1];
wire [0:associativity-1] way_valid;                     
wire [0:associativity-1] way_match;                     
wire miss;                                              
wire [ (addr_set_width-1):0] tmem_read_address;        
wire [ (addr_set_width-1):0] tmem_write_address;       
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_read_address;        
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_write_address;       
wire [ ((addr_tag_width+1)-1):0] tmem_write_data;               
reg [ (32-1):0] dmem_write_data;                   
reg [ 2:0] state;                         
wire flushing;                                          
wire check;                                             
wire refill;                                            
wire valid_store;                                       
reg [associativity-1:0] refill_way_select;              
reg [ addr_offset_msb:addr_offset_lsb] refill_offset;           
wire last_refill;                                       
reg [ (addr_set_width-1):0] flush_set;                 
genvar i, j;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
   generate
      for (i = 0; i < associativity; i = i + 1)    
	begin : memories
           if ( (addr_offset_width+addr_set_width) < 11)
             begin : data_memories
		lm32_ram 
		  #(
		    .data_width (32),
		    .address_width ( (addr_offset_width+addr_set_width))
		    ) way_0_data_ram 
		    (
		     .read_clk (clk_i),
		     .write_clk (clk_i),
		     .reset (rst_i),
		     .read_address (dmem_read_address),
		     .enable_read (read_port_enable),
		     .write_address (dmem_write_address),
		     .enable_write (write_port_enable),
		     .write_enable (way_dmem_we[i]),
		     .write_data (dmem_write_data),    
		     .read_data (way_data[i])
		     );    
             end
           else
             begin
		for (j = 0; j < 4; j = j + 1)    
		  begin : byte_memories
		     lm32_ram 
		       #(
			 .data_width (8),
			 .address_width ( (addr_offset_width+addr_set_width))
			 ) way_0_data_ram 
			 (
			  .read_clk (clk_i),
			  .write_clk (clk_i),
			  .reset (rst_i),
			  .read_address (dmem_read_address),
			  .enable_read (read_port_enable),
			  .write_address (dmem_write_address),
			  .enable_write (write_port_enable),
			  .write_enable (way_dmem_we[i] & (store_byte_select[j] | refill)),
			  .write_data (dmem_write_data[(j+1)*8-1:j*8]),    
			  .read_data (way_data[i][(j+1)*8-1:j*8])
			  );
		  end
             end
	   lm32_ram 
	     #(
	       .data_width ( (addr_tag_width+1)),
	       .address_width ( addr_set_width)
	       ) way_0_tag_ram 
	       (
		.read_clk (clk_i),
		.write_clk (clk_i),
		.reset (rst_i),
		.read_address (tmem_read_address),
		.enable_read (read_port_enable),
		.write_address (tmem_write_address),
		.enable_write ( 1'b1),
		.write_enable (way_tmem_we[i]),
		.write_data (tmem_write_data),
		.read_data ({way_tag[i], way_valid[i]})
		);
	end
   endgenerate
generate
    for (i = 0; i < associativity; i = i + 1)
    begin : match
assign way_match[i] = ({way_tag[i], way_valid[i]} == {address_m[ addr_tag_msb:addr_tag_lsb],  1'b1});
    end
endgenerate
generate
    if (associativity == 1)    
	 begin : data_1
assign load_data = way_data[0];
    end
    else if (associativity == 2)
	 begin : data_2
assign load_data = way_match[0] ? way_data[0] : way_data[1]; 
    end
endgenerate
generate
    if ( (addr_offset_width+addr_set_width) < 11)
    begin
always @(*)
begin
    if (refill ==  1'b1)
        dmem_write_data = refill_data;
    else
    begin
        dmem_write_data[ 7:0] = store_byte_select[0] ? store_data[ 7:0] : load_data[ 7:0];
        dmem_write_data[ 15:8] = store_byte_select[1] ? store_data[ 15:8] : load_data[ 15:8];
        dmem_write_data[ 23:16] = store_byte_select[2] ? store_data[ 23:16] : load_data[ 23:16];
        dmem_write_data[ 31:24] = store_byte_select[3] ? store_data[ 31:24] : load_data[ 31:24];
    end
end
    end
    else
    begin
always @(*)
begin
    if (refill ==  1'b1)
        dmem_write_data = refill_data;
    else
        dmem_write_data = store_data;
end
    end
endgenerate
generate 
     if (bytes_per_line > 4)
assign dmem_write_address = (refill ==  1'b1) 
                            ? {refill_address[ addr_set_msb:addr_set_lsb], refill_offset}
                            : address_m[ addr_set_msb:addr_offset_lsb];
    else
assign dmem_write_address = (refill ==  1'b1) 
                            ? refill_address[ addr_set_msb:addr_set_lsb]
                            : address_m[ addr_set_msb:addr_offset_lsb];
endgenerate
assign dmem_read_address = address_x[ addr_set_msb:addr_offset_lsb];
assign tmem_write_address = (flushing ==  1'b1)
                            ? flush_set
                            : refill_address[ addr_set_msb:addr_set_lsb];
assign tmem_read_address = address_x[ addr_set_msb:addr_set_lsb];
generate 
    if (bytes_per_line > 4)                            
assign last_refill = refill_offset == {addr_offset_width{1'b1}};
    else
assign last_refill =  1'b1;
endgenerate
assign read_port_enable = (stall_x ==  1'b0);
assign write_port_enable = (refill_ready ==  1'b1) || !stall_m;
assign valid_store = (store_q_m ==  1'b1) && (check ==  1'b1);
generate
    if (associativity == 1) 
    begin : we_1     
assign way_dmem_we[0] = (refill_ready ==  1'b1) || ((valid_store ==  1'b1) && (way_match[0] ==  1'b1));
assign way_tmem_we[0] = (refill_ready ==  1'b1) || (flushing ==  1'b1);
    end 
    else 
    begin : we_2
assign way_dmem_we[0] = ((refill_ready ==  1'b1) && (refill_way_select[0] ==  1'b1)) || ((valid_store ==  1'b1) && (way_match[0] ==  1'b1));
assign way_dmem_we[1] = ((refill_ready ==  1'b1) && (refill_way_select[1] ==  1'b1)) || ((valid_store ==  1'b1) && (way_match[1] ==  1'b1));
assign way_tmem_we[0] = ((refill_ready ==  1'b1) && (refill_way_select[0] ==  1'b1)) || (flushing ==  1'b1);
assign way_tmem_we[1] = ((refill_ready ==  1'b1) && (refill_way_select[1] ==  1'b1)) || (flushing ==  1'b1);
    end
endgenerate
assign tmem_write_data[ 0] = ((last_refill ==  1'b1) || (valid_store ==  1'b1)) && (flushing ==  1'b0);
assign tmem_write_data[ ((addr_tag_width+1)-1):1] = refill_address[ addr_tag_msb:addr_tag_lsb];
assign flushing = state[0];
assign check = state[1];
assign refill = state[2];
assign miss = (~(|way_match)) && (load_q_m ==  1'b1) && (stall_m ==  1'b0);
assign stall_request = (check ==  1'b0);
generate
    if (associativity >= 2) 
    begin : way_select      
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_way_select <= {{associativity-1{1'b0}}, 1'b1};
    else
    begin        
        if (refill_request ==  1'b1)
            refill_way_select <= {refill_way_select[0], refill_way_select[1]};
    end
end
    end 
endgenerate   
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refilling <=  1'b0;
    else 
        refilling <= refill;
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        state <=  3'b001;
        flush_set <= { addr_set_width{1'b1}};
        refill_request <=  1'b0;
        refill_address <= { 32{1'bx}};
        restart_request <=  1'b0;
    end
    else 
    begin
        case (state)
         3'b001:
        begin
            if (flush_set == { addr_set_width{1'b0}})
                state <=  3'b010;
            flush_set <= flush_set - 1'b1;
        end
         3'b010:
        begin
            if (stall_a ==  1'b0)
                restart_request <=  1'b0;
            if (miss ==  1'b1)
            begin
                refill_request <=  1'b1;
                refill_address <= address_m;
                state <=  3'b100;
            end
            else if (dflush ==  1'b1)
                state <=  3'b001;
        end
         3'b100:
        begin
            refill_request <=  1'b0;
            if (refill_ready ==  1'b1)
            begin
                if (last_refill ==  1'b1)
                begin
                    restart_request <=  1'b1;
                    state <=  3'b010;
                end
            end
        end
        endcase        
    end
end
generate
    if (bytes_per_line > 4)
    begin
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_offset <= {addr_offset_width{1'b0}};
    else 
    begin
        case (state)
         3'b010:
        begin
            if (miss ==  1'b1)
                refill_offset <= {addr_offset_width{1'b0}};
        end
         3'b100:
        begin
            if (refill_ready ==  1'b1)
                refill_offset <= refill_offset + 1'b1;
        end
        endcase        
    end
end
    end
endgenerate
endmodule
module lm32_debug_full_debug (
    clk_i, 
    rst_i,
    pc_x,
    load_x,
    store_x,
    load_store_address_x,
    csr_write_enable_x,
    csr_write_data,
    csr_x,
    jtag_csr_write_enable,
    jtag_csr_write_data,
    jtag_csr,
    eret_q_x,
    bret_q_x,
    stall_x,
    exception_x,
    q_x,
    dcache_refill_request,
    dc_ss,
    dc_re,
    bp_match,
    wp_match
    );
parameter breakpoints = 0;                      
parameter watchpoints = 0;                      
input clk_i;                                    
input rst_i;                                    
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;                      
input load_x;                                   
input store_x;                                  
input [ (32-1):0] load_store_address_x;    
input csr_write_enable_x;                       
input [ (32-1):0] csr_write_data;          
input [ (5-1):0] csr_x;                    
input jtag_csr_write_enable;                    
input [ (32-1):0] jtag_csr_write_data;     
input [ (5-1):0] jtag_csr;                 
input eret_q_x;                                 
input bret_q_x;                                 
input stall_x;                                  
input exception_x;                              
input q_x;                                      
input dcache_refill_request;                    
output dc_ss;                                   
reg    dc_ss;
output dc_re;                                   
reg    dc_re;
output bp_match;                                
wire   bp_match;        
output wp_match;                                
wire   wp_match;
genvar i;                                       
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] bp_a[0:breakpoints-1];       
reg bp_e[0:breakpoints-1];                      
wire [0:breakpoints-1]bp_match_n;               
reg [ 1:0] wpc_c[0:watchpoints-1];   
reg [ (32-1):0] wp[0:watchpoints-1];       
wire [0:watchpoints-1]wp_match_n;               
wire debug_csr_write_enable;                    
wire [ (32-1):0] debug_csr_write_data;     
wire [ (5-1):0] debug_csr;                 
reg [ 2:0] state;           
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
generate
    for (i = 0; i < breakpoints; i = i + 1)
    begin : bp_comb
assign bp_match_n[i] = ((bp_a[i] == pc_x) && (bp_e[i] ==  1'b1));
    end
endgenerate
generate 
    if (breakpoints > 0) 
assign bp_match = (|bp_match_n) || (state ==  3'b011);
    else
assign bp_match = state ==  3'b011;
endgenerate    
generate 
    for (i = 0; i < watchpoints; i = i + 1)
    begin : wp_comb
assign wp_match_n[i] = (wp[i] == load_store_address_x) && ((load_x & wpc_c[i][0]) | (store_x & wpc_c[i][1]));
    end               
endgenerate
generate
    if (watchpoints > 0) 
assign wp_match = |wp_match_n;                
    else
assign wp_match =  1'b0;
endgenerate
assign debug_csr_write_enable = (csr_write_enable_x ==  1'b1) || (jtag_csr_write_enable ==  1'b1);
assign debug_csr_write_data = jtag_csr_write_enable ==  1'b1 ? jtag_csr_write_data : csr_write_data;
assign debug_csr = jtag_csr_write_enable ==  1'b1 ? jtag_csr : csr_x;
generate
    for (i = 0; i < breakpoints; i = i + 1)
    begin : bp_seq
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        bp_a[i] <= { (clogb2(32'h7fffffff-32'h0)-2){1'bx}};
        bp_e[i] <=  1'b0;
    end
    else
    begin
        if ((debug_csr_write_enable ==  1'b1) && (debug_csr ==  5'h10 + i))
        begin
            bp_a[i] <= debug_csr_write_data[ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2];
            bp_e[i] <= debug_csr_write_data[0];
        end
    end
end    
    end
endgenerate
generate
    for (i = 0; i < watchpoints; i = i + 1)
    begin : wp_seq
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        wp[i] <= { 32{1'bx}};
        wpc_c[i] <=  2'b00;
    end
    else
    begin
        if (debug_csr_write_enable ==  1'b1)
        begin
            if (debug_csr ==  5'h8)
                wpc_c[i] <= debug_csr_write_data[3+i*2:2+i*2];
            if (debug_csr ==  5'h18 + i)
                wp[i] <= debug_csr_write_data;
        end
    end  
end
    end
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        dc_re <=  1'b0;
    else
    begin
        if ((debug_csr_write_enable ==  1'b1) && (debug_csr ==  5'h8))
            dc_re <= debug_csr_write_data[1];
    end
end    
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        state <=  3'b000;
        dc_ss <=  1'b0;
    end
    else
    begin
        if ((debug_csr_write_enable ==  1'b1) && (debug_csr ==  5'h8))
        begin
            dc_ss <= debug_csr_write_data[0];
            if (debug_csr_write_data[0] ==  1'b0) 
                state <=  3'b000;
            else 
                state <=  3'b001;
        end
        case (state)
         3'b001:
        begin
            if (   (   (eret_q_x ==  1'b1)
                    || (bret_q_x ==  1'b1)
                    )
                && (stall_x ==  1'b0)
               )
                state <=  3'b010; 
        end
         3'b010:
        begin
            if ((q_x ==  1'b1) && (stall_x ==  1'b0))
                state <=  3'b011;
        end
         3'b011:
        begin
            if (dcache_refill_request ==  1'b1)
                state <=  3'b010;
            else 
                 if ((exception_x ==  1'b1) && (q_x ==  1'b1) && (stall_x ==  1'b0))
            begin
                dc_ss <=  1'b0;
                state <=  3'b100;
            end
        end
         3'b100:
        begin
            if (dcache_refill_request ==  1'b1)
                state <=  3'b010;
            else 
                state <=  3'b000;
        end
        endcase
    end
end
endmodule
module lm32_instruction_unit_full_debug (
    clk_i,
    rst_i,
    stall_a,
    stall_f,
    stall_d,
    stall_x,
    stall_m,
    valid_f,
    valid_d,
    kill_f,
    branch_predict_taken_d,
    branch_predict_address_d,
    branch_taken_x,
    branch_target_x,
    exception_m,
    branch_taken_m,
    branch_mispredict_taken_m,
    branch_target_m,
    iflush,
    dcache_restart_request,
    dcache_refill_request,
    dcache_refilling,
    i_dat_i,
    i_ack_i,
    i_err_i,
    i_rty_i,
    jtag_read_enable,
    jtag_write_enable,
    jtag_write_data,
    jtag_address,
    pc_f,
    pc_d,
    pc_x,
    pc_m,
    pc_w,
    icache_stall_request,
    icache_restart_request,
    icache_refill_request,
    icache_refilling,
    i_dat_o,
    i_adr_o,
    i_cyc_o,
    i_sel_o,
    i_stb_o,
    i_we_o,
    i_cti_o,
    i_lock_o,
    i_bte_o,
    jtag_read_data,
    jtag_access_complete,
    bus_error_d,
    instruction_f,
    instruction_d
    );
parameter eba_reset =  32'h00000000;                   
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam eba_reset_minus_4 = eba_reset - 4;
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_f;                                          
input stall_d;                                          
input stall_x;                                          
input stall_m;                                          
input valid_f;                                          
input valid_d;                                          
input kill_f;                                           
input branch_predict_taken_d;                           
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_predict_address_d;          
input branch_taken_x;                                   
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_x;                   
input exception_m;
input branch_taken_m;                                   
input branch_mispredict_taken_m;                        
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_m;                   
input iflush;                                           
input dcache_restart_request;                           
input dcache_refill_request;                            
input dcache_refilling;
input [ (32-1):0] i_dat_i;                         
input i_ack_i;                                          
input i_err_i;                                          
input i_rty_i;                                          
input jtag_read_enable;                                 
input jtag_write_enable;                                
input [ 7:0] jtag_write_data;                 
input [ (32-1):0] jtag_address;                    
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;
output icache_stall_request;                            
wire   icache_stall_request;
output icache_restart_request;                          
wire   icache_restart_request;
output icache_refill_request;                           
wire   icache_refill_request;
output icache_refilling;                                
wire   icache_refilling;
output [ (32-1):0] i_dat_o;                        
reg    [ (32-1):0] i_dat_o;
output [ (32-1):0] i_adr_o;                        
reg    [ (32-1):0] i_adr_o;
output i_cyc_o;                                         
reg    i_cyc_o; 
output [ (4-1):0] i_sel_o;                 
reg    [ (4-1):0] i_sel_o;
output i_stb_o;                                         
reg    i_stb_o;
output i_we_o;                                          
reg    i_we_o;
output [ (3-1):0] i_cti_o;                       
reg    [ (3-1):0] i_cti_o;
output i_lock_o;                                        
reg    i_lock_o;
output [ (2-1):0] i_bte_o;                       
wire   [ (2-1):0] i_bte_o;
output [ 7:0] jtag_read_data;                 
reg    [ 7:0] jtag_read_data;
output jtag_access_complete;                            
wire   jtag_access_complete;
output bus_error_d;                                     
reg    bus_error_d;
output [ (32-1):0] instruction_f;           
wire   [ (32-1):0] instruction_f;
output [ (32-1):0] instruction_d;           
reg    [ (32-1):0] instruction_d;
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_a;                                
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] restart_address;                     
wire icache_read_enable_f;                              
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] icache_refill_address;              
reg icache_refill_ready;                                
reg [ (32-1):0] icache_refill_data;         
wire [ (32-1):0] icache_data_f;             
wire [ (3-1):0] first_cycle_type;                
wire [ (3-1):0] next_cycle_type;                 
wire last_word;                                         
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] first_address;                      
reg bus_error_f;                                        
reg jtag_access;                                        
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_icache_full_debug #(
    .associativity          (associativity),
    .sets                   (sets),
    .bytes_per_line         (bytes_per_line),
    .base_address           (base_address),
    .limit                  (limit)
    ) icache ( 
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),      
    .stall_a                (stall_a),
    .stall_f                (stall_f),
    .branch_predict_taken_d (branch_predict_taken_d),
    .valid_d                (valid_d),
    .address_a              (pc_a),
    .address_f              (pc_f),
    .read_enable_f          (icache_read_enable_f),
    .refill_ready           (icache_refill_ready),
    .refill_data            (icache_refill_data),
    .iflush                 (iflush),
    .stall_request          (icache_stall_request),
    .restart_request        (icache_restart_request),
    .refill_request         (icache_refill_request),
    .refill_address         (icache_refill_address),
    .refilling              (icache_refilling),
    .inst                   (icache_data_f)
    );
assign icache_read_enable_f =    (valid_f ==  1'b1)
                              && (kill_f ==  1'b0)
                              && (dcache_restart_request ==  1'b0)
                              ;
always @(*)
begin
    if (dcache_restart_request ==  1'b1)
        pc_a = restart_address;
    else 
      if (branch_taken_m ==  1'b1)
	if ((branch_mispredict_taken_m ==  1'b1) && (exception_m ==  1'b0))
	  pc_a = pc_x;
	else
          pc_a = branch_target_m;
      else if (branch_taken_x ==  1'b1)
        pc_a = branch_target_x;
      else
	if ( (valid_d ==  1'b1) && (branch_predict_taken_d ==  1'b1) )
	  pc_a = branch_predict_address_d;
	else
          if (icache_restart_request ==  1'b1)
            pc_a = restart_address;
	  else 
            pc_a = pc_f + 1'b1;
end
assign instruction_f = icache_data_f;
assign i_bte_o =  2'b00;
generate
    case (bytes_per_line)
    4:
    begin
assign first_cycle_type =  3'b111;
assign next_cycle_type =  3'b111;
assign last_word =  1'b1;
assign first_address = icache_refill_address;
    end
    8:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type =  3'b111;
assign last_word = i_adr_o[addr_offset_msb:addr_offset_lsb] == 1'b1;
assign first_address = {icache_refill_address[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:addr_offset_msb+1], {addr_offset_width{1'b0}}};
    end
    16:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type = i_adr_o[addr_offset_msb] == 1'b1 ?  3'b111 :  3'b010;
assign last_word = i_adr_o[addr_offset_msb:addr_offset_lsb] == 2'b11;
assign first_address = {icache_refill_address[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:addr_offset_msb+1], {addr_offset_width{1'b0}}};
    end
    endcase
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        pc_f <= eba_reset_minus_4[ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2];
        pc_d <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_x <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_m <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_w <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
    end
    else
    begin
        if (stall_f ==  1'b0)
            pc_f <= pc_a;
        if (stall_d ==  1'b0)
            pc_d <= pc_f;
        if (stall_x ==  1'b0)
            pc_x <= pc_d;
        if (stall_m ==  1'b0)
            pc_m <= pc_x;
        pc_w <= pc_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        restart_address <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
    else
    begin
            if (dcache_refill_request ==  1'b1)
                restart_address <= pc_w;
            else if ((icache_refill_request ==  1'b1) && (!dcache_refilling) && (!dcache_restart_request))
                restart_address <= icache_refill_address;
    end
end
assign jtag_access_complete = (i_cyc_o ==  1'b1) && ((i_ack_i ==  1'b1) || (i_err_i ==  1'b1)) && (jtag_access ==  1'b1);
always @(*)
begin
    case (jtag_address[1:0])
    2'b00: jtag_read_data = i_dat_i[ 31:24];
    2'b01: jtag_read_data = i_dat_i[ 23:16];
    2'b10: jtag_read_data = i_dat_i[ 15:8];
    2'b11: jtag_read_data = i_dat_i[ 7:0];
    endcase 
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        i_cyc_o <=  1'b0;
        i_stb_o <=  1'b0;
        i_adr_o <= { 32{1'b0}};
        i_cti_o <=  3'b111;
        i_lock_o <=  1'b0;
        icache_refill_data <= { 32{1'b0}};
        icache_refill_ready <=  1'b0;
        bus_error_f <=  1'b0;
        i_we_o <=  1'b0;
        i_sel_o <= 4'b1111;
        jtag_access <=  1'b0;
    end
    else
    begin   
        icache_refill_ready <=  1'b0;
        if (i_cyc_o ==  1'b1)
        begin
            if ((i_ack_i ==  1'b1) || (i_err_i ==  1'b1))
            begin
                if (jtag_access ==  1'b1)
                begin
                    i_cyc_o <=  1'b0;
                    i_stb_o <=  1'b0;       
                    i_we_o <=  1'b0;  
                    jtag_access <=  1'b0;    
                end
                else
                begin
                    if (last_word ==  1'b1)
                    begin
                        i_cyc_o <=  1'b0;
                        i_stb_o <=  1'b0;
                        i_lock_o <=  1'b0;
                    end
                    i_adr_o[addr_offset_msb:addr_offset_lsb] <= i_adr_o[addr_offset_msb:addr_offset_lsb] + 1'b1;
                    i_cti_o <= next_cycle_type;
                    icache_refill_ready <=  1'b1;
                    icache_refill_data <= i_dat_i;
                end
            end
            if (i_err_i ==  1'b1)
            begin
                bus_error_f <=  1'b1;
                $display ("Instruction bus error. Address: %x", i_adr_o);
            end
        end
        else
        begin
            if ((icache_refill_request ==  1'b1) && (icache_refill_ready ==  1'b0))
            begin
                i_sel_o <= 4'b1111;
                i_adr_o <= {first_address, 2'b00};
                i_cyc_o <=  1'b1;
                i_stb_o <=  1'b1;                
                i_cti_o <= first_cycle_type;
                bus_error_f <=  1'b0;
            end
            else
            begin
                if ((jtag_read_enable ==  1'b1) || (jtag_write_enable ==  1'b1))
                begin
                    case (jtag_address[1:0])
                    2'b00: i_sel_o <= 4'b1000;
                    2'b01: i_sel_o <= 4'b0100;
                    2'b10: i_sel_o <= 4'b0010;
                    2'b11: i_sel_o <= 4'b0001;
                    endcase
                    i_adr_o <= jtag_address;
                    i_dat_o <= {4{jtag_write_data}};
                    i_cyc_o <=  1'b1;
                    i_stb_o <=  1'b1;
                    i_we_o <= jtag_write_enable;
                    i_cti_o <=  3'b111;
                    jtag_access <=  1'b1;
                end
            end 
            if (branch_taken_x ==  1'b1)
                bus_error_f <=  1'b0;
            if (branch_taken_m ==  1'b1)
                bus_error_f <=  1'b0;
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        instruction_d <= { 32{1'b0}};
        bus_error_d <=  1'b0;
    end
    else
    begin
        if (stall_d ==  1'b0)
        begin
            instruction_d <= instruction_f;
            bus_error_d <= bus_error_f;
        end
    end
end  
endmodule
module lm32_jtag_full_debug (
    clk_i,
    rst_i,
    jtag_clk, 
    jtag_update,
    jtag_reg_q,
    jtag_reg_addr_q,
    csr,
    csr_write_enable,
    csr_write_data,
    stall_x,
    jtag_read_data,
    jtag_access_complete,
    exception_q_w,
    jtx_csr_read_data,
    jrx_csr_read_data,
    jtag_csr_write_enable,
    jtag_csr_write_data,
    jtag_csr,
    jtag_read_enable,
    jtag_write_enable,
    jtag_write_data,
    jtag_address,
    jtag_break,
    jtag_reset,
    jtag_reg_d,
    jtag_reg_addr_d
    );
input clk_i;                                            
input rst_i;                                            
input jtag_clk;                                         
input jtag_update;                                      
input [ 7:0] jtag_reg_q;                      
input [2:0] jtag_reg_addr_q;                            
input [ (5-1):0] csr;                              
input csr_write_enable;                                 
input [ (32-1):0] csr_write_data;                  
input stall_x;                                          
input [ 7:0] jtag_read_data;                  
input jtag_access_complete;                             
input exception_q_w;                                    
output [ (32-1):0] jtx_csr_read_data;              
wire   [ (32-1):0] jtx_csr_read_data;
output [ (32-1):0] jrx_csr_read_data;              
wire   [ (32-1):0] jrx_csr_read_data;
output jtag_csr_write_enable;                           
reg    jtag_csr_write_enable;
output [ (32-1):0] jtag_csr_write_data;            
wire   [ (32-1):0] jtag_csr_write_data;
output [ (5-1):0] jtag_csr;                        
wire   [ (5-1):0] jtag_csr;
output jtag_read_enable;                                
reg    jtag_read_enable;
output jtag_write_enable;                               
reg    jtag_write_enable;
output [ 7:0] jtag_write_data;                
wire   [ 7:0] jtag_write_data;        
output [ (32-1):0] jtag_address;                   
wire   [ (32-1):0] jtag_address;
output jtag_break;                                      
reg    jtag_break;
output jtag_reset;                                      
reg    jtag_reset;
output [ 7:0] jtag_reg_d;
reg    [ 7:0] jtag_reg_d;
output [2:0] jtag_reg_addr_d;
wire   [2:0] jtag_reg_addr_d;
reg rx_update;                          
reg rx_update_r;                        
reg rx_update_r_r;                      
reg rx_update_r_r_r;                    
wire [ 7:0] rx_byte;   
wire [2:0] rx_addr;
reg [ 7:0] uart_tx_byte;      
reg uart_tx_valid;                      
reg [ 7:0] uart_rx_byte;      
reg uart_rx_valid;                      
reg [ 3:0] command;             
reg [ 7:0] jtag_byte_0;       
reg [ 7:0] jtag_byte_1;
reg [ 7:0] jtag_byte_2;
reg [ 7:0] jtag_byte_3;
reg [ 7:0] jtag_byte_4;
reg processing;                         
reg [ 3:0] state;       
assign jtag_csr_write_data = {jtag_byte_0, jtag_byte_1, jtag_byte_2, jtag_byte_3};
assign jtag_csr = jtag_byte_4[ (5-1):0];
assign jtag_address = {jtag_byte_0, jtag_byte_1, jtag_byte_2, jtag_byte_3};
assign jtag_write_data = jtag_byte_4;
assign jtag_reg_addr_d[1:0] = {uart_rx_valid, uart_tx_valid};         
assign jtag_reg_addr_d[2] = processing;
assign jtx_csr_read_data = {{ 32-9{1'b0}}, uart_tx_valid, 8'h00};
assign jrx_csr_read_data = {{ 32-9{1'b0}}, uart_rx_valid, uart_rx_byte};
assign rx_byte = jtag_reg_q;
assign rx_addr = jtag_reg_addr_q;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        rx_update <= 1'b0;
        rx_update_r <= 1'b0;
        rx_update_r_r <= 1'b0;
        rx_update_r_r_r <= 1'b0;
    end
    else
    begin
        rx_update <= jtag_update;
        rx_update_r <= rx_update;
        rx_update_r_r <= rx_update_r;
        rx_update_r_r_r <= rx_update_r_r;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        state <=  4'h0;
        command <= 4'b0000;
        jtag_reg_d <= 8'h00;
        processing <=  1'b0;
        jtag_csr_write_enable <=  1'b0;
        jtag_read_enable <=  1'b0;
        jtag_write_enable <=  1'b0;
        jtag_break <=  1'b0;
        jtag_reset <=  1'b0;
        uart_tx_byte <= 8'h00;
        uart_tx_valid <=  1'b0;
        uart_rx_byte <= 8'h00;
        uart_rx_valid <=  1'b0;
    end
    else
    begin
        if ((csr_write_enable ==  1'b1) && (stall_x ==  1'b0))
        begin
            case (csr)
             5'he:
            begin
                uart_tx_byte <= csr_write_data[ 7:0];
                uart_tx_valid <=  1'b1;
            end
             5'hf:
            begin
                uart_rx_valid <=  1'b0;
            end
            endcase
        end
        if (exception_q_w ==  1'b1)
        begin
            jtag_break <=  1'b0;
            jtag_reset <=  1'b0;
        end
        case (state)
         4'h0:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                command <= rx_byte[7:4];                
                case (rx_addr)
                 3'b000:
                begin
                    case (rx_byte[7:4])
                     4'b0001:
                        state <=  4'h1;
                     4'b0011:
                    begin
                        {jtag_byte_2, jtag_byte_3} <= {jtag_byte_2, jtag_byte_3} + 1'b1;
                        state <=  4'h6;
                    end
                     4'b0010:
                        state <=  4'h1;
                     4'b0100:
                    begin
                        {jtag_byte_2, jtag_byte_3} <= {jtag_byte_2, jtag_byte_3} + 1'b1;
                        state <= 5;
                    end
                     4'b0101:
                        state <=  4'h1;
                     4'b0110:
                    begin
                        uart_rx_valid <=  1'b0;    
                        uart_tx_valid <=  1'b0;         
                        jtag_break <=  1'b1;
                    end
                     4'b0111:
                    begin
                        uart_rx_valid <=  1'b0;    
                        uart_tx_valid <=  1'b0;         
                        jtag_reset <=  1'b1;
                    end
                    endcase                               
                end
                 3'b001:
                begin
                    uart_rx_byte <= rx_byte;
                    uart_rx_valid <=  1'b1;
                end                    
                 3'b010:
                begin
                    jtag_reg_d <= uart_tx_byte;
                    uart_tx_valid <=  1'b0;
                end
                default:
                    ;
                endcase                
            end
        end
         4'h1:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_0 <= rx_byte;
                state <=  4'h2;
            end
        end
         4'h2:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_1 <= rx_byte;
                state <=  4'h3;
            end
        end
         4'h3:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_2 <= rx_byte;
                state <=  4'h4;
            end
        end
         4'h4:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_3 <= rx_byte;
                if (command ==  4'b0001)
                    state <=  4'h6;
                else 
                    state <=  4'h5;
            end
        end
         4'h5:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_4 <= rx_byte;
                state <=  4'h6;
            end
        end
         4'h6:
        begin
            case (command)
             4'b0001,
             4'b0011:
            begin
                jtag_read_enable <=  1'b1;
                processing <=  1'b1;
                state <=  4'h7;
            end
             4'b0010,
             4'b0100:
            begin
                jtag_write_enable <=  1'b1;
                processing <=  1'b1;
                state <=  4'h7;
            end
             4'b0101:
            begin
                jtag_csr_write_enable <=  1'b1;
                processing <=  1'b1;
                state <=  4'h8;
            end
            endcase
        end
         4'h7:
        begin
            if (jtag_access_complete ==  1'b1)
            begin          
                jtag_read_enable <=  1'b0;
                jtag_reg_d <= jtag_read_data;
                jtag_write_enable <=  1'b0;  
                processing <=  1'b0;
                state <=  4'h0;
            end
        end    
         4'h8:
        begin
            jtag_csr_write_enable <=  1'b0;
            processing <=  1'b0;
            state <=  4'h0;
        end    
        endcase
    end
end
endmodule
module lm32_interrupt_full_debug (
    clk_i, 
    rst_i,
    interrupt,
    stall_x,
    non_debug_exception,
    debug_exception,
    eret_q_x,
    bret_q_x,
    csr,
    csr_write_data,
    csr_write_enable,
    interrupt_exception,
    csr_read_data
    );
parameter interrupts =  32;         
input clk_i;                                    
input rst_i;                                    
input [interrupts-1:0] interrupt;               
input stall_x;                                  
input non_debug_exception;                      
input debug_exception;                          
input eret_q_x;                                 
input bret_q_x;                                 
input [ (5-1):0] csr;                      
input [ (32-1):0] csr_write_data;          
input csr_write_enable;                         
output interrupt_exception;                     
wire   interrupt_exception;
output [ (32-1):0] csr_read_data;          
reg    [ (32-1):0] csr_read_data;
wire [interrupts-1:0] asserted;                 
wire [interrupts-1:0] interrupt_n_exception;
reg ie;                                         
reg eie;                                        
reg bie;                                        
reg [interrupts-1:0] ip;                        
reg [interrupts-1:0] im;                        
assign interrupt_n_exception = ip & im;
assign interrupt_exception = (|interrupt_n_exception) & ie;
assign asserted = ip | interrupt;
generate
    if (interrupts > 1) 
    begin
always @(*)
begin
    case (csr)
     5'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    bie,
                                    eie, 
                                    ie
                                   };
     5'h2:  csr_read_data = ip;
     5'h1:  csr_read_data = im;
    default:       csr_read_data = { 32{1'bx}};
    endcase
end
    end
    else
    begin
always @(*)
begin
    case (csr)
     5'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    bie, 
                                    eie, 
                                    ie
                                   };
     5'h2:  csr_read_data = ip;
    default:       csr_read_data = { 32{1'bx}};
      endcase
end
    end
endgenerate
   reg [ 10:0] eie_delay  = 0;
generate
    if (interrupts > 1)
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie                   <=  1'b0;
        eie                  <=  1'b0;
        bie                  <=  1'b0;
        im                   <= {interrupts{1'b0}};
        ip                   <= {interrupts{1'b0}};
       eie_delay             <= 0;
    end
    else
    begin
        ip                   <= asserted;
        if (non_debug_exception ==  1'b1)
        begin
            eie              <= ie;
            ie               <=  1'b0;
        end
        else if (debug_exception ==  1'b1)
        begin
            bie              <= ie;
            ie               <=  1'b0;
        end
        else if (stall_x ==  1'b0)
        begin
           if(eie_delay[0])
             ie              <= eie;
           eie_delay         <= {1'b0, eie_delay[ 10:1]};
            if (eret_q_x ==  1'b1) begin
               eie_delay[ 10] <=  1'b1;
               eie_delay[ 10-1:0] <= 0;
            end
            else if (bret_q_x ==  1'b1)
                ie      <= bie;
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  5'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                    bie <= csr_write_data[2];
                end
                if (csr ==  5'h1)
                    im  <= csr_write_data[interrupts-1:0];
                if (csr ==  5'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
else
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie              <=  1'b0;
        eie             <=  1'b0;
        bie             <=  1'b0;
        ip              <= {interrupts{1'b0}};
       eie_delay        <= 0;
    end
    else
    begin
        ip              <= asserted;
        if (non_debug_exception ==  1'b1)
        begin
            eie         <= ie;
            ie          <=  1'b0;
        end
        else if (debug_exception ==  1'b1)
        begin
            bie         <= ie;
            ie          <=  1'b0;
        end
        else if (stall_x ==  1'b0)
          begin
             if(eie_delay[0])
               ie              <= eie;
             eie_delay         <= {1'b0, eie_delay[ 10:1]};
             if (eret_q_x ==  1'b1) begin
                eie_delay[ 10] <=  1'b1;
                eie_delay[ 10-1:0] <= 0;
             end
            else if (bret_q_x ==  1'b1)
                ie      <= bie;
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  5'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                    bie <= csr_write_data[2];
                end
                if (csr ==  5'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
endgenerate
endmodule
module lm32_top_medium (
    clk_i,
    rst_i,
    interrupt,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset = 32'h00000000;
parameter sdb_address = 32'h00000000;
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_cpu_medium 
	#(
		.eba_reset(eba_reset),
    .sdb_address(sdb_address)
	) cpu (
    .clk_i                 (clk_i),
    .rst_i                 (rst_i),
    .interrupt             (interrupt),
    .I_DAT_I               (I_DAT_I),
    .I_ACK_I               (I_ACK_I),
    .I_ERR_I               (I_ERR_I),
    .I_RTY_I               (I_RTY_I),
    .D_DAT_I               (D_DAT_I),
    .D_ACK_I               (D_ACK_I),
    .D_ERR_I               (D_ERR_I),
    .D_RTY_I               (D_RTY_I),
    .I_DAT_O               (I_DAT_O),
    .I_ADR_O               (I_ADR_O),
    .I_CYC_O               (I_CYC_O),
    .I_SEL_O               (I_SEL_O),
    .I_STB_O               (I_STB_O),
    .I_WE_O                (I_WE_O),
    .I_CTI_O               (I_CTI_O),
    .I_LOCK_O              (I_LOCK_O),
    .I_BTE_O               (I_BTE_O),
    .D_DAT_O               (D_DAT_O),
    .D_ADR_O               (D_ADR_O),
    .D_CYC_O               (D_CYC_O),
    .D_SEL_O               (D_SEL_O),
    .D_STB_O               (D_STB_O),
    .D_WE_O                (D_WE_O),
    .D_CTI_O               (D_CTI_O),
    .D_LOCK_O              (D_LOCK_O),
    .D_BTE_O               (D_BTE_O)
    );
endmodule
module lm32_mc_arithmetic_medium (
    clk_i,
    rst_i,
    stall_d,
    kill_x,
    operand_0_d,
    operand_1_d,
    result_x,
    stall_request_x
    );
input clk_i;                                    
input rst_i;                                    
input stall_d;                                  
input kill_x;                                   
input [ (32-1):0] operand_0_d;
input [ (32-1):0] operand_1_d;
output [ (32-1):0] result_x;               
reg    [ (32-1):0] result_x;
output stall_request_x;                         
wire   stall_request_x;
reg [ (32-1):0] p;                         
reg [ (32-1):0] a;
reg [ (32-1):0] b;
reg [ 2:0] state;                 
reg [5:0] cycles;                               
assign stall_request_x = state !=  3'b000;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        cycles <= {6{1'b0}};
        p <= { 32{1'b0}};
        a <= { 32{1'b0}};
        b <= { 32{1'b0}};
        result_x <= { 32{1'b0}};
        state <=  3'b000;
    end
    else
    begin
        case (state)
         3'b000:
        begin
            if (stall_d ==  1'b0)                 
            begin          
                cycles <=  32;
                p <= 32'b0;
                a <= operand_0_d;
                b <= operand_1_d;                    
            end            
        end
        endcase
    end
end 
endmodule
module lm32_cpu_medium (
    clk_i,
    rst_i,
    interrupt,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset =  32'h00000000;                           
parameter sdb_address =   32'h00000000;
parameter icache_associativity = 1;    
parameter icache_sets = 512;                      
parameter icache_bytes_per_line = 16;  
parameter icache_base_address = 0;      
parameter icache_limit = 0;                    
parameter dcache_associativity = 1;    
parameter dcache_sets = 512;                      
parameter dcache_bytes_per_line = 16;  
parameter dcache_base_address = 0;      
parameter dcache_limit = 0;                    
parameter watchpoints = 0;
parameter breakpoints = 0;
parameter interrupts =  32;                         
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
reg valid_f;                                    
reg valid_d;                                    
reg valid_x;                                    
reg valid_m;                                    
reg valid_w;                                    
wire q_x;
wire [ (32-1):0] immediate_d;              
wire load_d;                                    
reg load_x;                                     
reg load_m;
wire load_q_x;
wire store_q_x;
wire q_m;
wire load_q_m;
wire store_q_m;
wire store_d;                                   
reg store_x;
reg store_m;
wire [ 1:0] size_d;                   
reg [ 1:0] size_x;
wire branch_d;                                  
wire branch_predict_d;                          
wire branch_predict_taken_d;                    
wire [ ((32-2)+2-1):2] branch_predict_address_d;   
wire [ ((32-2)+2-1):2] branch_target_d;
wire bi_unconditional;
wire bi_conditional;
reg branch_x;                                   
reg branch_predict_x;
reg branch_predict_taken_x;
reg branch_m;
reg branch_predict_m;
reg branch_predict_taken_m;
wire branch_mispredict_taken_m;                 
wire branch_flushX_m;                           
wire branch_reg_d;                              
wire [ ((32-2)+2-1):2] branch_offset_d;            
reg [ ((32-2)+2-1):2] branch_target_x;             
reg [ ((32-2)+2-1):2] branch_target_m;
wire [ 0:0] d_result_sel_0_d; 
wire [ 1:0] d_result_sel_1_d; 
wire x_result_sel_csr_d;                        
reg x_result_sel_csr_x;
wire x_result_sel_sext_d;                       
reg x_result_sel_sext_x;
wire x_result_sel_logic_d;                      
wire x_result_sel_add_d;                        
reg x_result_sel_add_x;
wire m_result_sel_compare_d;                    
reg m_result_sel_compare_x;
reg m_result_sel_compare_m;
wire m_result_sel_shift_d;                      
reg m_result_sel_shift_x;
reg m_result_sel_shift_m;
wire w_result_sel_load_d;                       
reg w_result_sel_load_x;
reg w_result_sel_load_m;
reg w_result_sel_load_w;
wire w_result_sel_mul_d;                        
reg w_result_sel_mul_x;
reg w_result_sel_mul_m;
reg w_result_sel_mul_w;
wire x_bypass_enable_d;                         
reg x_bypass_enable_x;                          
wire m_bypass_enable_d;                         
reg m_bypass_enable_x;                          
reg m_bypass_enable_m;
wire sign_extend_d;                             
reg sign_extend_x;
wire write_enable_d;                            
reg write_enable_x;
wire write_enable_q_x;
reg write_enable_m;
wire write_enable_q_m;
reg write_enable_w;
wire write_enable_q_w;
wire read_enable_0_d;                           
wire [ (5-1):0] read_idx_0_d;          
wire read_enable_1_d;                           
wire [ (5-1):0] read_idx_1_d;          
wire [ (5-1):0] write_idx_d;           
reg [ (5-1):0] write_idx_x;            
reg [ (5-1):0] write_idx_m;
reg [ (5-1):0] write_idx_w;
wire [ (4 -1):0] csr_d;                     
reg  [ (4 -1):0] csr_x;                  
wire [ (3-1):0] condition_d;         
reg [ (3-1):0] condition_x;          
wire scall_d;                                   
reg scall_x;    
wire eret_d;                                    
reg eret_x;
wire eret_q_x;
wire csr_write_enable_d;                        
reg csr_write_enable_x;
wire csr_write_enable_q_x;
reg [ (32-1):0] d_result_0;                
reg [ (32-1):0] d_result_1;                
reg [ (32-1):0] x_result;                  
reg [ (32-1):0] m_result;                  
reg [ (32-1):0] w_result;                  
reg [ (32-1):0] operand_0_x;               
reg [ (32-1):0] operand_1_x;               
reg [ (32-1):0] store_operand_x;           
reg [ (32-1):0] operand_m;                 
reg [ (32-1):0] operand_w;                 
reg [ (32-1):0] reg_data_live_0;          
reg [ (32-1):0] reg_data_live_1;  
reg use_buf;                                    
reg [ (32-1):0] reg_data_buf_0;
reg [ (32-1):0] reg_data_buf_1;
wire [ (32-1):0] reg_data_0;               
wire [ (32-1):0] reg_data_1;               
reg [ (32-1):0] bypass_data_0;             
reg [ (32-1):0] bypass_data_1;             
wire reg_write_enable_q_w;
reg interlock;                                  
wire stall_a;                                   
wire stall_f;                                   
wire stall_d;                                   
wire stall_x;                                   
wire stall_m;                                   
wire adder_op_d;                                
reg adder_op_x;                                 
reg adder_op_x_n;                               
wire [ (32-1):0] adder_result_x;           
wire adder_overflow_x;                          
wire adder_carry_n_x;                           
wire [ 3:0] logic_op_d;           
reg [ 3:0] logic_op_x;            
wire [ (32-1):0] logic_result_x;           
wire [ (32-1):0] sextb_result_x;           
wire [ (32-1):0] sexth_result_x;           
wire [ (32-1):0] sext_result_x;            
wire direction_d;                               
reg direction_x;                                        
wire [ (32-1):0] shifter_result_m;         
wire [ (32-1):0] multiplier_result_w;      
wire [ (32-1):0] interrupt_csr_read_data_x;
wire [ (32-1):0] cfg;                      
wire [ (32-1):0] cfg2;                     
reg [ (32-1):0] csr_read_data_x;           
wire [ ((32-2)+2-1):2] pc_f;                       
wire [ ((32-2)+2-1):2] pc_d;                       
wire [ ((32-2)+2-1):2] pc_x;                       
wire [ ((32-2)+2-1):2] pc_m;                       
wire [ ((32-2)+2-1):2] pc_w;                       
wire [ (32-1):0] instruction_f;     
wire [ (32-1):0] instruction_d;     
wire [ (32-1):0] load_data_w;              
wire stall_wb_load;                             
wire raw_x_0;                                   
wire raw_x_1;                                   
wire raw_m_0;                                   
wire raw_m_1;                                   
wire raw_w_0;                                   
wire raw_w_1;                                   
wire cmp_zero;                                  
wire cmp_negative;                              
wire cmp_overflow;                              
wire cmp_carry_n;                               
reg condition_met_x;                            
reg condition_met_m;
wire branch_taken_m;                            
wire kill_f;                                    
wire kill_d;                                    
wire kill_x;                                    
wire kill_m;                                    
wire kill_w;                                    
reg [ (32-2)+2-1:8] eba;                 
reg [ (3-1):0] eid_x;                      
wire exception_x;                               
reg exception_m;
reg exception_w;
wire exception_q_w;
wire interrupt_exception;                       
wire system_call_exception;                     
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_instruction_unit_medium #(
    .eba_reset              (eba_reset),
    .associativity          (icache_associativity),
    .sets                   (icache_sets),
    .bytes_per_line         (icache_bytes_per_line),
    .base_address           (icache_base_address),
    .limit                  (icache_limit)
  ) instruction_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_f                (stall_f),
    .stall_d                (stall_d),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .valid_f                (valid_f),
    .valid_d                (valid_d),
    .kill_f                 (kill_f),
    .branch_predict_taken_d (branch_predict_taken_d),
    .branch_predict_address_d (branch_predict_address_d),
    .exception_m            (exception_m),
    .branch_taken_m         (branch_taken_m),
    .branch_mispredict_taken_m (branch_mispredict_taken_m),
    .branch_target_m        (branch_target_m),
    .i_dat_i                (I_DAT_I),
    .i_ack_i                (I_ACK_I),
    .i_err_i                (I_ERR_I),
    .i_rty_i                (I_RTY_I),
    .pc_f                   (pc_f),
    .pc_d                   (pc_d),
    .pc_x                   (pc_x),
    .pc_m                   (pc_m),
    .pc_w                   (pc_w),
    .i_dat_o                (I_DAT_O),
    .i_adr_o                (I_ADR_O),
    .i_cyc_o                (I_CYC_O),
    .i_sel_o                (I_SEL_O),
    .i_stb_o                (I_STB_O),
    .i_we_o                 (I_WE_O),
    .i_cti_o                (I_CTI_O),
    .i_lock_o               (I_LOCK_O),
    .i_bte_o                (I_BTE_O),
    .instruction_f          (instruction_f),
    .instruction_d          (instruction_d)
    );
lm32_decoder_medium decoder (
    .instruction            (instruction_d),
    .d_result_sel_0         (d_result_sel_0_d),
    .d_result_sel_1         (d_result_sel_1_d),
    .x_result_sel_csr       (x_result_sel_csr_d),
    .x_result_sel_sext      (x_result_sel_sext_d),
    .x_result_sel_logic     (x_result_sel_logic_d),
    .x_result_sel_add       (x_result_sel_add_d),
    .m_result_sel_compare   (m_result_sel_compare_d),
    .m_result_sel_shift     (m_result_sel_shift_d),  
    .w_result_sel_load      (w_result_sel_load_d),
    .w_result_sel_mul       (w_result_sel_mul_d),
    .x_bypass_enable        (x_bypass_enable_d),
    .m_bypass_enable        (m_bypass_enable_d),
    .read_enable_0          (read_enable_0_d),
    .read_idx_0             (read_idx_0_d),
    .read_enable_1          (read_enable_1_d),
    .read_idx_1             (read_idx_1_d),
    .write_enable           (write_enable_d),
    .write_idx              (write_idx_d),
    .immediate              (immediate_d),
    .branch_offset          (branch_offset_d),
    .load                   (load_d),
    .store                  (store_d),
    .size                   (size_d),
    .sign_extend            (sign_extend_d),
    .adder_op               (adder_op_d),
    .logic_op               (logic_op_d),
    .direction              (direction_d),
    .branch                 (branch_d),
    .bi_unconditional       (bi_unconditional),
    .bi_conditional         (bi_conditional),
    .branch_reg             (branch_reg_d),
    .condition              (condition_d),
    .scall                  (scall_d),
    .eret                   (eret_d),
    .csr_write_enable       (csr_write_enable_d)
    ); 
lm32_load_store_unit_medium #(
    .associativity          (dcache_associativity),
    .sets                   (dcache_sets),
    .bytes_per_line         (dcache_bytes_per_line),
    .base_address           (dcache_base_address),
    .limit                  (dcache_limit)
  ) load_store_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .kill_x                 (kill_x),
    .kill_m                 (kill_m),
    .exception_m            (exception_m),
    .store_operand_x        (store_operand_x),
    .load_store_address_x   (adder_result_x),
    .load_store_address_m   (operand_m),
    .load_store_address_w   (operand_w[1:0]),
    .load_x                 (load_x),
    .store_x                (store_x),
    .load_q_x               (load_q_x),
    .store_q_x              (store_q_x),
    .load_q_m               (load_q_m),
    .store_q_m              (store_q_m),
    .sign_extend_x          (sign_extend_x),
    .size_x                 (size_x),
    .d_dat_i                (D_DAT_I),
    .d_ack_i                (D_ACK_I),
    .d_err_i                (D_ERR_I),
    .d_rty_i                (D_RTY_I),
    .load_data_w            (load_data_w),
    .stall_wb_load          (stall_wb_load),
    .d_dat_o                (D_DAT_O),
    .d_adr_o                (D_ADR_O),
    .d_cyc_o                (D_CYC_O),
    .d_sel_o                (D_SEL_O),
    .d_stb_o                (D_STB_O),
    .d_we_o                 (D_WE_O),
    .d_cti_o                (D_CTI_O),
    .d_lock_o               (D_LOCK_O),
    .d_bte_o                (D_BTE_O)
    );      
lm32_adder adder (
    .adder_op_x             (adder_op_x),
    .adder_op_x_n           (adder_op_x_n),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .adder_result_x         (adder_result_x),
    .adder_carry_n_x        (adder_carry_n_x),
    .adder_overflow_x       (adder_overflow_x)
    );
lm32_logic_op logic_op (
    .logic_op_x             (logic_op_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .logic_result_x         (logic_result_x)
    );
lm32_shifter shifter (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .direction_x            (direction_x),
    .sign_extend_x          (sign_extend_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .shifter_result_m       (shifter_result_m)
    );
lm32_multiplier multiplier (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .operand_0              (d_result_0),
    .operand_1              (d_result_1),
    .result                 (multiplier_result_w)    
    );
lm32_interrupt_medium interrupt_unit (
    .clk_i                  (clk_i), 
    .rst_i                  (rst_i),
    .interrupt              (interrupt),
    .stall_x                (stall_x),
    .exception              (exception_q_w), 
    .eret_q_x               (eret_q_x),
    .csr                    (csr_x),
    .csr_write_data         (operand_1_x),
    .csr_write_enable       (csr_write_enable_q_x),
    .interrupt_exception    (interrupt_exception),
    .csr_read_data          (interrupt_csr_read_data_x)
    );
   wire [31:0] regfile_data_0, regfile_data_1;
   reg [31:0]  w_result_d;
   reg 	       regfile_raw_0, regfile_raw_0_nxt;
   reg 	       regfile_raw_1, regfile_raw_1_nxt;
   always @(reg_write_enable_q_w or write_idx_w or instruction_f)
     begin
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[25:21]))
	  regfile_raw_0_nxt = 1'b1;
	else
	  regfile_raw_0_nxt = 1'b0;
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[20:16]))
	  regfile_raw_1_nxt = 1'b1;
	else
	  regfile_raw_1_nxt = 1'b0;
     end
   always @(regfile_raw_0 or w_result_d or regfile_data_0)
     if (regfile_raw_0)
       reg_data_live_0 = w_result_d;
     else
       reg_data_live_0 = regfile_data_0;
   always @(regfile_raw_1 or w_result_d or regfile_data_1)
     if (regfile_raw_1)
       reg_data_live_1 = w_result_d;
     else
       reg_data_live_1 = regfile_data_1;
   always @(posedge clk_i  )
     if (rst_i ==  1'b1)
       begin
	  regfile_raw_0 <= 1'b0;
	  regfile_raw_1 <= 1'b0;
	  w_result_d <= 32'b0;
       end
     else
       begin
	  regfile_raw_0 <= regfile_raw_0_nxt;
	  regfile_raw_1 <= regfile_raw_1_nxt;
	  w_result_d <= w_result;
       end
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_0
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[25:21]),
      .rdata_o	(regfile_data_0)
      );
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_1
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[20:16]),
      .rdata_o	(regfile_data_1)
      );
assign reg_data_0 = use_buf ? reg_data_buf_0 : reg_data_live_0;
assign reg_data_1 = use_buf ? reg_data_buf_1 : reg_data_live_1;
assign raw_x_0 = (write_idx_x == read_idx_0_d) && (write_enable_q_x ==  1'b1);
assign raw_m_0 = (write_idx_m == read_idx_0_d) && (write_enable_q_m ==  1'b1);
assign raw_w_0 = (write_idx_w == read_idx_0_d) && (write_enable_q_w ==  1'b1);
assign raw_x_1 = (write_idx_x == read_idx_1_d) && (write_enable_q_x ==  1'b1);
assign raw_m_1 = (write_idx_m == read_idx_1_d) && (write_enable_q_m ==  1'b1);
assign raw_w_1 = (write_idx_w == read_idx_1_d) && (write_enable_q_w ==  1'b1);
always @(*)
begin
    if (   (   (x_bypass_enable_x ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_x_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_x_1 ==  1'b1))
               )
           )
        || (   (m_bypass_enable_m ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_m_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_m_1 ==  1'b1))
               )
           )
       )
        interlock =  1'b1;
    else
        interlock =  1'b0;
end
always @(*)
begin
    if (raw_x_0 ==  1'b1)        
        bypass_data_0 = x_result;
    else if (raw_m_0 ==  1'b1)
        bypass_data_0 = m_result;
    else if (raw_w_0 ==  1'b1)
        bypass_data_0 = w_result;
    else
        bypass_data_0 = reg_data_0;
end
always @(*)
begin
    if (raw_x_1 ==  1'b1)
        bypass_data_1 = x_result;
    else if (raw_m_1 ==  1'b1)
        bypass_data_1 = m_result;
    else if (raw_w_1 ==  1'b1)
        bypass_data_1 = w_result;
    else
        bypass_data_1 = reg_data_1;
end
   assign branch_predict_d = bi_unconditional | bi_conditional;
   assign branch_predict_taken_d = bi_unconditional ? 1'b1 : (bi_conditional ? instruction_d[15] : 1'b0);
   assign branch_target_d = pc_d + branch_offset_d;
   assign branch_predict_address_d = branch_predict_taken_d ? branch_target_d : pc_f;
always @(*)
begin
    d_result_0 = d_result_sel_0_d[0] ? {pc_f, 2'b00} : bypass_data_0; 
    case (d_result_sel_1_d)
     2'b00:      d_result_1 = { 32{1'b0}};
     2'b01:     d_result_1 = bypass_data_1;
     2'b10: d_result_1 = immediate_d;
    default:                        d_result_1 = { 32{1'bx}};
    endcase
end
assign sextb_result_x = {{24{operand_0_x[7]}}, operand_0_x[7:0]};
assign sexth_result_x = {{16{operand_0_x[15]}}, operand_0_x[15:0]};
assign sext_result_x = size_x ==  2'b00 ? sextb_result_x : sexth_result_x;
assign cmp_zero = operand_0_x == operand_1_x;
assign cmp_negative = adder_result_x[ 32-1];
assign cmp_overflow = adder_overflow_x;
assign cmp_carry_n = adder_carry_n_x;
always @(*)
begin
    case (condition_x)
     3'b000:   condition_met_x =  1'b1;
     3'b110:   condition_met_x =  1'b1;
     3'b001:    condition_met_x = cmp_zero;
     3'b111:   condition_met_x = !cmp_zero;
     3'b010:    condition_met_x = !cmp_zero && (cmp_negative == cmp_overflow);
     3'b101:   condition_met_x = cmp_carry_n && !cmp_zero;
     3'b011:   condition_met_x = cmp_negative == cmp_overflow;
     3'b100:  condition_met_x = cmp_carry_n;
    default:              condition_met_x = 1'bx;
    endcase 
end
always @(*)
begin
    x_result =   x_result_sel_add_x ? adder_result_x 
               : x_result_sel_csr_x ? csr_read_data_x
               : x_result_sel_sext_x ? sext_result_x
               : logic_result_x;
end
always @(*)
begin
    m_result =   m_result_sel_compare_m ? {{ 32-1{1'b0}}, condition_met_m}
               : m_result_sel_shift_m ? shifter_result_m
               : operand_m; 
end
always @(*)
begin
    w_result =    w_result_sel_load_w ? load_data_w
                : w_result_sel_mul_w ? multiplier_result_w
                : operand_w;
end
assign branch_taken_m =      (stall_m ==  1'b0) 
                          && (   (   (branch_m ==  1'b1) 
                                  && (valid_m ==  1'b1)
                                  && (   (   (condition_met_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b0)
					 )
				      || (   (condition_met_m ==  1'b0)
					  && (branch_predict_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b1)
					 )
				     )
                                 ) 
                              || (exception_m ==  1'b1)
                             );
assign branch_mispredict_taken_m =    (condition_met_m ==  1'b0)
                                   && (branch_predict_m ==  1'b1)
	   			   && (branch_predict_taken_m ==  1'b1);
assign branch_flushX_m =    (stall_m ==  1'b0)
                         && (   (   (branch_m ==  1'b1) 
                                 && (valid_m ==  1'b1)
			         && (   (condition_met_m ==  1'b1)
				     || (   (condition_met_m ==  1'b0)
					 && (branch_predict_m ==  1'b1)
					 && (branch_predict_taken_m ==  1'b1)
					)
				    )
			        )
			     || (exception_m ==  1'b1)
			    );
assign kill_f =    (   (valid_d ==  1'b1)
                    && (branch_predict_taken_d ==  1'b1)
		   )
                || (branch_taken_m ==  1'b1) 
                ;
assign kill_d =    (branch_taken_m ==  1'b1) 
                ;
assign kill_x =    (branch_flushX_m ==  1'b1) 
                ;
assign kill_m =     1'b0
                ;                
assign kill_w =     1'b0
                ;
assign system_call_exception = (   (scall_x ==  1'b1)
			       );
assign exception_x =           (system_call_exception ==  1'b1)
                            || (   (interrupt_exception ==  1'b1)
                               )
                            ;
always @(*)
begin
         if (   (interrupt_exception ==  1'b1)
            )
        eid_x =  3'h6;
    else
        eid_x =  3'h7;
end
assign stall_a = (stall_f ==  1'b1);
assign stall_f = (stall_d ==  1'b1);
assign stall_d =   (stall_x ==  1'b1) 
                || (   (interlock ==  1'b1)
                    && (kill_d ==  1'b0)
                   ) 
		|| (   (   (eret_d ==  1'b1)
			|| (scall_d ==  1'b1)
		       )
		    && (   (load_q_x ==  1'b1)
			|| (load_q_m ==  1'b1)
			|| (store_q_x ==  1'b1)
			|| (store_q_m ==  1'b1)
			|| (D_CYC_O ==  1'b1)
		       )
                    && (kill_d ==  1'b0)
		   )
                || (   (csr_write_enable_d ==  1'b1)
                    && (load_q_x ==  1'b1)
                   )                      
                ;
assign stall_x =    (stall_m ==  1'b1)
                 ;
assign stall_m =    (stall_wb_load ==  1'b1)
                 || (   (D_CYC_O ==  1'b1)
                     && (   (store_m ==  1'b1)
		         || ((store_x ==  1'b1) && (interrupt_exception ==  1'b1))
                         || (load_m ==  1'b1)
                         || (load_x ==  1'b1)
                        ) 
                    ) 
                 || (I_CYC_O ==  1'b1)            
                 ;      
assign q_x = (valid_x ==  1'b1) && (kill_x ==  1'b0);
assign csr_write_enable_q_x = (csr_write_enable_x ==  1'b1) && (q_x ==  1'b1);
assign eret_q_x = (eret_x ==  1'b1) && (q_x ==  1'b1);
assign load_q_x = (load_x ==  1'b1) 
               && (q_x ==  1'b1)
                  ;
assign store_q_x = (store_x ==  1'b1) 
               && (q_x ==  1'b1)
                  ;
assign q_m = (valid_m ==  1'b1) && (kill_m ==  1'b0) && (exception_m ==  1'b0);
assign load_q_m = (load_m ==  1'b1) && (q_m ==  1'b1);
assign store_q_m = (store_m ==  1'b1) && (q_m ==  1'b1);
assign exception_q_w = ((exception_w ==  1'b1) && (valid_w ==  1'b1));        
assign write_enable_q_x = (write_enable_x ==  1'b1) && (valid_x ==  1'b1) && (branch_flushX_m ==  1'b0);
assign write_enable_q_m = (write_enable_m ==  1'b1) && (valid_m ==  1'b1);
assign write_enable_q_w = (write_enable_w ==  1'b1) && (valid_w ==  1'b1);
assign reg_write_enable_q_w = (write_enable_w ==  1'b1) && (kill_w ==  1'b0) && (valid_w ==  1'b1);
assign cfg = {
               6'h02,
              watchpoints[3:0],
              breakpoints[3:0],
              interrupts[5:0],
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b1,
               1'b1,
               1'b0,
               1'b1
              };
assign cfg2 = {
		     30'b0,
		      1'b0,
		      1'b0
		     };
assign csr_d = read_idx_0_d[ (4 -1):0];
always @(*)
begin
    case (csr_x)
     4 'h0,
     4 'h1,
     4 'h2:   csr_read_data_x = interrupt_csr_read_data_x;  
     4 'h6:  csr_read_data_x = cfg;
     4 'h7:  csr_read_data_x = {eba, 8'h00};
     4 'ha: csr_read_data_x = cfg2;
     4 'hb:  csr_read_data_x = sdb_address;
    default:        csr_read_data_x = { 32{1'bx}};
    endcase
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        eba <= eba_reset[ (32-2)+2-1:8];
    else
    begin
        if ((csr_write_enable_q_x ==  1'b1) && (csr_x ==  4 'h7) && (stall_x ==  1'b0))
            eba <= operand_1_x[ (32-2)+2-1:8];
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        valid_f <=  1'b0;
        valid_d <=  1'b0;
        valid_x <=  1'b0;
        valid_m <=  1'b0;
        valid_w <=  1'b0;
    end
    else
    begin    
        if ((kill_f ==  1'b1) || (stall_a ==  1'b0))
            valid_f <=  1'b1;
        else if (stall_f ==  1'b0)
            valid_f <=  1'b0;            
        if (kill_d ==  1'b1)
            valid_d <=  1'b0;
        else if (stall_f ==  1'b0)
            valid_d <= valid_f & !kill_f;
        else if (stall_d ==  1'b0)
            valid_d <=  1'b0;
        if (stall_d ==  1'b0)
            valid_x <= valid_d & !kill_d;
        else if (kill_x ==  1'b1)
            valid_x <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_x <=  1'b0;
        if (kill_m ==  1'b1)
            valid_m <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_m <= valid_x & !kill_x;
        else if (stall_m ==  1'b0)
            valid_m <=  1'b0;
        if (stall_m ==  1'b0)
            valid_w <= valid_m & !kill_m;
        else 
            valid_w <=  1'b0;        
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        operand_0_x <= { 32{1'b0}};
        operand_1_x <= { 32{1'b0}};
        store_operand_x <= { 32{1'b0}};
        branch_target_x <= { (32-2){1'b0}};        
        x_result_sel_csr_x <=  1'b0;
        x_result_sel_sext_x <=  1'b0;
        x_result_sel_add_x <=  1'b0;
        m_result_sel_compare_x <=  1'b0;
        m_result_sel_shift_x <=  1'b0;
        w_result_sel_load_x <=  1'b0;
        w_result_sel_mul_x <=  1'b0;
        x_bypass_enable_x <=  1'b0;
        m_bypass_enable_x <=  1'b0;
        write_enable_x <=  1'b0;
        write_idx_x <= { 5{1'b0}};
        csr_x <= { 4 {1'b0}};
        load_x <=  1'b0;
        store_x <=  1'b0;
        size_x <= { 2{1'b0}};
        sign_extend_x <=  1'b0;
        adder_op_x <=  1'b0;
        adder_op_x_n <=  1'b0;
        logic_op_x <= 4'h0;
        direction_x <=  1'b0;
        branch_x <=  1'b0;
        branch_predict_x <=  1'b0;
        branch_predict_taken_x <=  1'b0;
        condition_x <=  3'b000;
        scall_x <=  1'b0;
        eret_x <=  1'b0;
        csr_write_enable_x <=  1'b0;
        operand_m <= { 32{1'b0}};
        branch_target_m <= { (32-2){1'b0}};
        m_result_sel_compare_m <=  1'b0;
        m_result_sel_shift_m <=  1'b0;
        w_result_sel_load_m <=  1'b0;
        w_result_sel_mul_m <=  1'b0;
        m_bypass_enable_m <=  1'b0;
        branch_m <=  1'b0;
        branch_predict_m <=  1'b0;
	branch_predict_taken_m <=  1'b0;
        exception_m <=  1'b0;
        load_m <=  1'b0;
        store_m <=  1'b0;
        write_enable_m <=  1'b0;            
        write_idx_m <= { 5{1'b0}};
        condition_met_m <=  1'b0;
        operand_w <= { 32{1'b0}};        
        w_result_sel_load_w <=  1'b0;
        w_result_sel_mul_w <=  1'b0;
        write_idx_w <= { 5{1'b0}};        
        write_enable_w <=  1'b0;
        exception_w <=  1'b0;
    end
    else
    begin
        if (stall_x ==  1'b0)
        begin
            operand_0_x <= d_result_0;
            operand_1_x <= d_result_1;
            store_operand_x <= bypass_data_1;
            branch_target_x <= branch_reg_d ==  1'b1 ? bypass_data_0[ ((32-2)+2-1):2] : branch_target_d;            
            x_result_sel_csr_x <= x_result_sel_csr_d;
            x_result_sel_sext_x <= x_result_sel_sext_d;
            x_result_sel_add_x <= x_result_sel_add_d;
            m_result_sel_compare_x <= m_result_sel_compare_d;
            m_result_sel_shift_x <= m_result_sel_shift_d;
            w_result_sel_load_x <= w_result_sel_load_d;
            w_result_sel_mul_x <= w_result_sel_mul_d;
            x_bypass_enable_x <= x_bypass_enable_d;
            m_bypass_enable_x <= m_bypass_enable_d;
            load_x <= load_d;
            store_x <= store_d;
            branch_x <= branch_d;
	    branch_predict_x <= branch_predict_d;
	    branch_predict_taken_x <= branch_predict_taken_d;
	    write_idx_x <= write_idx_d;
            csr_x <= csr_d;
            size_x <= size_d;
            sign_extend_x <= sign_extend_d;
            adder_op_x <= adder_op_d;
            adder_op_x_n <= ~adder_op_d;
            logic_op_x <= logic_op_d;
            direction_x <= direction_d;
            condition_x <= condition_d;
            csr_write_enable_x <= csr_write_enable_d;
            scall_x <= scall_d;
            eret_x <= eret_d;
            write_enable_x <= write_enable_d;
        end
        if (stall_m ==  1'b0)
        begin
            operand_m <= x_result;
            m_result_sel_compare_m <= m_result_sel_compare_x;
            m_result_sel_shift_m <= m_result_sel_shift_x;
            if (exception_x ==  1'b1)
            begin
                w_result_sel_load_m <=  1'b0;
                w_result_sel_mul_m <=  1'b0;
            end
            else
            begin
                w_result_sel_load_m <= w_result_sel_load_x;
                w_result_sel_mul_m <= w_result_sel_mul_x;
            end
            m_bypass_enable_m <= m_bypass_enable_x;
            load_m <= load_x;
            store_m <= store_x;
            branch_m <= branch_x;
	    branch_predict_m <= branch_predict_x;
	    branch_predict_taken_m <= branch_predict_taken_x;
            if (exception_x ==  1'b1)
                write_idx_m <=  5'd30;
            else 
                write_idx_m <= write_idx_x;
            condition_met_m <= condition_met_x;
            branch_target_m <= exception_x ==  1'b1 ? {eba, eid_x, {3{1'b0}}} : branch_target_x;
            write_enable_m <= exception_x ==  1'b1 ?  1'b1 : write_enable_x;            
        end
        if (stall_m ==  1'b0)
        begin
            if ((exception_x ==  1'b1) && (q_x ==  1'b1) && (stall_x ==  1'b0))
                exception_m <=  1'b1;
            else 
                exception_m <=  1'b0;
	end
        operand_w <= exception_m ==  1'b1 ? {pc_m, 2'b00} : m_result;
        w_result_sel_load_w <= w_result_sel_load_m;
        w_result_sel_mul_w <= w_result_sel_mul_m;
        write_idx_w <= write_idx_m;
        write_enable_w <= write_enable_m;
        exception_w <= exception_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        use_buf <=  1'b0;
        reg_data_buf_0 <= { 32{1'b0}};
        reg_data_buf_1 <= { 32{1'b0}};
    end
    else
    begin
        if (stall_d ==  1'b0)
            use_buf <=  1'b0;
        else if (use_buf ==  1'b0)
        begin        
            reg_data_buf_0 <= reg_data_live_0;
            reg_data_buf_1 <= reg_data_live_1;
            use_buf <=  1'b1;
        end        
        if (reg_write_enable_q_w ==  1'b1)
        begin
            if (write_idx_w == read_idx_0_d)
                reg_data_buf_0 <= w_result;
            if (write_idx_w == read_idx_1_d)
                reg_data_buf_1 <= w_result;
        end
    end
end
initial
begin
end
endmodule 
module lm32_load_store_unit_medium (
    clk_i,
    rst_i,
    stall_a,
    stall_x,
    stall_m,
    kill_x,
    kill_m,
    exception_m,
    store_operand_x,
    load_store_address_x,
    load_store_address_m,
    load_store_address_w,
    load_x,
    store_x,
    load_q_x,
    store_q_x,
    load_q_m,
    store_q_m,
    sign_extend_x,
    size_x,
    d_dat_i,
    d_ack_i,
    d_err_i,
    d_rty_i,
    load_data_w,
    stall_wb_load,
    d_dat_o,
    d_adr_o,
    d_cyc_o,
    d_sel_o,
    d_stb_o,
    d_we_o,
    d_cti_o,
    d_lock_o,
    d_bte_o
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_x;                                          
input stall_m;                                          
input kill_x;                                           
input kill_m;                                           
input exception_m;                                      
input [ (32-1):0] store_operand_x;                 
input [ (32-1):0] load_store_address_x;            
input [ (32-1):0] load_store_address_m;            
input [1:0] load_store_address_w;                       
input load_x;                                           
input store_x;                                          
input load_q_x;                                         
input store_q_x;                                        
input load_q_m;                                         
input store_q_m;                                        
input sign_extend_x;                                    
input [ 1:0] size_x;                          
input [ (32-1):0] d_dat_i;                         
input d_ack_i;                                          
input d_err_i;                                          
input d_rty_i;                                          
output [ (32-1):0] load_data_w;                    
reg    [ (32-1):0] load_data_w;
output stall_wb_load;                                   
reg    stall_wb_load;
output [ (32-1):0] d_dat_o;                        
reg    [ (32-1):0] d_dat_o;
output [ (32-1):0] d_adr_o;                        
reg    [ (32-1):0] d_adr_o;
output d_cyc_o;                                         
reg    d_cyc_o;
output [ (4-1):0] d_sel_o;                 
reg    [ (4-1):0] d_sel_o;
output d_stb_o;                                         
reg    d_stb_o; 
output d_we_o;                                          
reg    d_we_o;
output [ (3-1):0] d_cti_o;                       
reg    [ (3-1):0] d_cti_o;
output d_lock_o;                                        
reg    d_lock_o;
output [ (2-1):0] d_bte_o;                       
wire   [ (2-1):0] d_bte_o;
reg [ 1:0] size_m;
reg [ 1:0] size_w;
reg sign_extend_m;
reg sign_extend_w;
reg [ (32-1):0] store_data_x;       
reg [ (32-1):0] store_data_m;       
reg [ (4-1):0] byte_enable_x;
reg [ (4-1):0] byte_enable_m;
wire [ (32-1):0] data_m;
reg [ (32-1):0] data_w;
wire wb_select_x;                                       
reg wb_select_m;
reg [ (32-1):0] wb_data_m;                         
reg wb_load_complete;                                   
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
   assign wb_select_x =     1'b1
                     ;
always @(*)
begin
    case (size_x)
     2'b00:  store_data_x = {4{store_operand_x[7:0]}};
     2'b11: store_data_x = {2{store_operand_x[15:0]}};
     2'b10:  store_data_x = store_operand_x;    
    default:          store_data_x = { 32{1'bx}};
    endcase
end
always @(*)
begin
    casez ({size_x, load_store_address_x[1:0]})
    { 2'b00, 2'b11}:  byte_enable_x = 4'b0001;
    { 2'b00, 2'b10}:  byte_enable_x = 4'b0010;
    { 2'b00, 2'b01}:  byte_enable_x = 4'b0100;
    { 2'b00, 2'b00}:  byte_enable_x = 4'b1000;
    { 2'b11, 2'b1?}: byte_enable_x = 4'b0011;
    { 2'b11, 2'b0?}: byte_enable_x = 4'b1100;
    { 2'b10, 2'b??}:  byte_enable_x = 4'b1111;
    default:                   byte_enable_x = 4'bxxxx;
    endcase
end
   assign data_m = wb_data_m;
always @(*)
begin
    casez ({size_w, load_store_address_w[1:0]})
    { 2'b00, 2'b11}:  load_data_w = {{24{sign_extend_w & data_w[7]}}, data_w[7:0]};
    { 2'b00, 2'b10}:  load_data_w = {{24{sign_extend_w & data_w[15]}}, data_w[15:8]};
    { 2'b00, 2'b01}:  load_data_w = {{24{sign_extend_w & data_w[23]}}, data_w[23:16]};
    { 2'b00, 2'b00}:  load_data_w = {{24{sign_extend_w & data_w[31]}}, data_w[31:24]};
    { 2'b11, 2'b1?}: load_data_w = {{16{sign_extend_w & data_w[15]}}, data_w[15:0]};
    { 2'b11, 2'b0?}: load_data_w = {{16{sign_extend_w & data_w[31]}}, data_w[31:16]};
    { 2'b10, 2'b??}:  load_data_w = data_w;
    default:                   load_data_w = { 32{1'bx}};
    endcase
end
assign d_bte_o =  2'b00;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        d_cyc_o <=  1'b0;
        d_stb_o <=  1'b0;
        d_dat_o <= { 32{1'b0}};
        d_adr_o <= { 32{1'b0}};
        d_sel_o <= { 4{ 1'b0}};
        d_we_o <=  1'b0;
        d_cti_o <=  3'b111;
        d_lock_o <=  1'b0;
        wb_data_m <= { 32{1'b0}};
        wb_load_complete <=  1'b0;
        stall_wb_load <=  1'b0;
    end
    else
    begin
        if (d_cyc_o ==  1'b1)
        begin
            if ((d_ack_i ==  1'b1) || (d_err_i ==  1'b1))
            begin
                begin
                    d_cyc_o <=  1'b0;
                    d_stb_o <=  1'b0;
                    d_lock_o <=  1'b0;
                end
                wb_data_m <= d_dat_i;
                wb_load_complete <= !d_we_o;
            end
            if (d_err_i ==  1'b1)
                $display ("Data bus error. Address: %x", d_adr_o);
        end
        else
        begin
                 if (   (store_q_m ==  1'b1)
                     && (stall_m ==  1'b0)
                    )
            begin
                d_dat_o <= store_data_m;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b1;
                d_cti_o <=  3'b111;
            end        
            else if (   (load_q_m ==  1'b1) 
                     && (wb_select_m ==  1'b1) 
                     && (wb_load_complete ==  1'b0)
                    )
            begin
                stall_wb_load <=  1'b0;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b0;
                d_cti_o <=  3'b111;
            end
        end
        if (stall_m ==  1'b0)
            wb_load_complete <=  1'b0;
        if ((load_q_x ==  1'b1) && (wb_select_x ==  1'b1) && (stall_x ==  1'b0))
            stall_wb_load <=  1'b1;
        if ((kill_m ==  1'b1) || (exception_m ==  1'b1))
            stall_wb_load <=  1'b0;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        sign_extend_m <=  1'b0;
        size_m <= 2'b00;
        byte_enable_m <=  1'b0;
        store_data_m <= { 32{1'b0}};
        wb_select_m <=  1'b0;        
    end
    else
    begin
        if (stall_m ==  1'b0)
        begin
            sign_extend_m <= sign_extend_x;
            size_m <= size_x;
            byte_enable_m <= byte_enable_x;    
            store_data_m <= store_data_x;
            wb_select_m <= wb_select_x;
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        size_w <= 2'b00;
        data_w <= { 32{1'b0}};
        sign_extend_w <=  1'b0;
    end
    else
    begin
        size_w <= size_m;
        data_w <= data_m;
        sign_extend_w <= sign_extend_m;
    end
end
always @(posedge clk_i)
begin
    if (((load_q_m ==  1'b1) || (store_q_m ==  1'b1)) && (stall_m ==  1'b0)) 
    begin
        if ((size_m ===  2'b11) && (load_store_address_m[0] !== 1'b0))
            $display ("Warning: Non-aligned halfword access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
        if ((size_m ===  2'b10) && (load_store_address_m[1:0] !== 2'b00))
            $display ("Warning: Non-aligned word access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
    end
end
endmodule
module lm32_decoder_medium (
    instruction,
    d_result_sel_0,
    d_result_sel_1,        
    x_result_sel_csr,
    x_result_sel_sext,
    x_result_sel_logic,
    x_result_sel_add,
    m_result_sel_compare,
    m_result_sel_shift,  
    w_result_sel_load,
    w_result_sel_mul,
    x_bypass_enable,
    m_bypass_enable,
    read_enable_0,
    read_idx_0,
    read_enable_1,
    read_idx_1,
    write_enable,
    write_idx,
    immediate,
    branch_offset,
    load,
    store,
    size,
    sign_extend,
    adder_op,
    logic_op,
    direction,
    branch,
    branch_reg,
    condition,
    bi_conditional,
    bi_unconditional,
    scall,
    eret,
    csr_write_enable
    );
input [ (32-1):0] instruction;       
output [ 0:0] d_result_sel_0;
reg    [ 0:0] d_result_sel_0;
output [ 1:0] d_result_sel_1;
reg    [ 1:0] d_result_sel_1;
output x_result_sel_csr;
reg    x_result_sel_csr;
output x_result_sel_sext;
reg    x_result_sel_sext;
output x_result_sel_logic;
reg    x_result_sel_logic;
output x_result_sel_add;
reg    x_result_sel_add;
output m_result_sel_compare;
reg    m_result_sel_compare;
output m_result_sel_shift;
reg    m_result_sel_shift;
output w_result_sel_load;
reg    w_result_sel_load;
output w_result_sel_mul;
reg    w_result_sel_mul;
output x_bypass_enable;
wire   x_bypass_enable;
output m_bypass_enable;
wire   m_bypass_enable;
output read_enable_0;
wire   read_enable_0;
output [ (5-1):0] read_idx_0;
wire   [ (5-1):0] read_idx_0;
output read_enable_1;
wire   read_enable_1;
output [ (5-1):0] read_idx_1;
wire   [ (5-1):0] read_idx_1;
output write_enable;
wire   write_enable;
output [ (5-1):0] write_idx;
wire   [ (5-1):0] write_idx;
output [ (32-1):0] immediate;
wire   [ (32-1):0] immediate;
output [ ((32-2)+2-1):2] branch_offset;
wire   [ ((32-2)+2-1):2] branch_offset;
output load;
wire   load;
output store;
wire   store;
output [ 1:0] size;
wire   [ 1:0] size;
output sign_extend;
wire   sign_extend;
output adder_op;
wire   adder_op;
output [ 3:0] logic_op;
wire   [ 3:0] logic_op;
output direction;
wire   direction;
output branch;
wire   branch;
output branch_reg;
wire   branch_reg;
output [ (3-1):0] condition;
wire   [ (3-1):0] condition;
output bi_conditional;
wire bi_conditional;
output bi_unconditional;
wire bi_unconditional;
output scall;
wire   scall;
output eret;
wire   eret;
output csr_write_enable;
wire   csr_write_enable;
wire [ (32-1):0] extended_immediate;       
wire [ (32-1):0] high_immediate;           
wire [ (32-1):0] call_immediate;           
wire [ (32-1):0] branch_immediate;         
wire sign_extend_immediate;                     
wire select_high_immediate;                     
wire select_call_immediate;                     
wire op_add;
wire op_and;
wire op_andhi;
wire op_b;
wire op_bi;
wire op_be;
wire op_bg;
wire op_bge;
wire op_bgeu;
wire op_bgu;
wire op_bne;
wire op_call;
wire op_calli;
wire op_cmpe;
wire op_cmpg;
wire op_cmpge;
wire op_cmpgeu;
wire op_cmpgu;
wire op_cmpne;
wire op_lb;
wire op_lbu;
wire op_lh;
wire op_lhu;
wire op_lw;
wire op_mul;
wire op_nor;
wire op_or;
wire op_orhi;
wire op_raise;
wire op_rcsr;
wire op_sb;
wire op_sextb;
wire op_sexth;
wire op_sh;
wire op_sl;
wire op_sr;
wire op_sru;
wire op_sub;
wire op_sw;
wire op_wcsr;
wire op_xnor;
wire op_xor;
wire arith;
wire logical;
wire cmp;
wire bra;
wire call;
wire shift;
wire sext;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
assign op_add    = instruction[ 30:26] ==  5'b01101;
assign op_and    = instruction[ 30:26] ==  5'b01000;
assign op_andhi  = instruction[ 31:26] ==  6'b011000;
assign op_b      = instruction[ 31:26] ==  6'b110000;
assign op_bi     = instruction[ 31:26] ==  6'b111000;
assign op_be     = instruction[ 31:26] ==  6'b010001;
assign op_bg     = instruction[ 31:26] ==  6'b010010;
assign op_bge    = instruction[ 31:26] ==  6'b010011;
assign op_bgeu   = instruction[ 31:26] ==  6'b010100;
assign op_bgu    = instruction[ 31:26] ==  6'b010101;
assign op_bne    = instruction[ 31:26] ==  6'b010111;
assign op_call   = instruction[ 31:26] ==  6'b110110;
assign op_calli  = instruction[ 31:26] ==  6'b111110;
assign op_cmpe   = instruction[ 30:26] ==  5'b11001;
assign op_cmpg   = instruction[ 30:26] ==  5'b11010;
assign op_cmpge  = instruction[ 30:26] ==  5'b11011;
assign op_cmpgeu = instruction[ 30:26] ==  5'b11100;
assign op_cmpgu  = instruction[ 30:26] ==  5'b11101;
assign op_cmpne  = instruction[ 30:26] ==  5'b11111;
assign op_lb     = instruction[ 31:26] ==  6'b000100;
assign op_lbu    = instruction[ 31:26] ==  6'b010000;
assign op_lh     = instruction[ 31:26] ==  6'b000111;
assign op_lhu    = instruction[ 31:26] ==  6'b001011;
assign op_lw     = instruction[ 31:26] ==  6'b001010;
assign op_mul    = instruction[ 30:26] ==  5'b00010;
assign op_nor    = instruction[ 30:26] ==  5'b00001;
assign op_or     = instruction[ 30:26] ==  5'b01110;
assign op_orhi   = instruction[ 31:26] ==  6'b011110;
assign op_raise  = instruction[ 31:26] ==  6'b101011;
assign op_rcsr   = instruction[ 31:26] ==  6'b100100;
assign op_sb     = instruction[ 31:26] ==  6'b001100;
assign op_sextb  = instruction[ 31:26] ==  6'b101100;
assign op_sexth  = instruction[ 31:26] ==  6'b110111;
assign op_sh     = instruction[ 31:26] ==  6'b000011;
assign op_sl     = instruction[ 30:26] ==  5'b01111;      
assign op_sr     = instruction[ 30:26] ==  5'b00101;
assign op_sru    = instruction[ 30:26] ==  5'b00000;
assign op_sub    = instruction[ 31:26] ==  6'b110010;
assign op_sw     = instruction[ 31:26] ==  6'b010110;
assign op_wcsr   = instruction[ 31:26] ==  6'b110100;
assign op_xnor   = instruction[ 30:26] ==  5'b01001;
assign op_xor    = instruction[ 30:26] ==  5'b00110;
assign arith = op_add | op_sub;
assign logical = op_and | op_andhi | op_nor | op_or | op_orhi | op_xor | op_xnor;
assign cmp = op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne;
assign bi_conditional = op_be | op_bg | op_bge | op_bgeu  | op_bgu | op_bne;
assign bi_unconditional = op_bi;
assign bra = op_b | bi_unconditional | bi_conditional;
assign call = op_call | op_calli;
assign shift = op_sl | op_sr | op_sru;
assign sext = op_sextb | op_sexth;
assign load = op_lb | op_lbu | op_lh | op_lhu | op_lw;
assign store = op_sb | op_sh | op_sw;
always @(*)
begin
    if (call) 
        d_result_sel_0 =  1'b1;
    else 
        d_result_sel_0 =  1'b0;
    if (call) 
        d_result_sel_1 =  2'b00;         
    else if ((instruction[31] == 1'b0) && !bra) 
        d_result_sel_1 =  2'b10;
    else
        d_result_sel_1 =  2'b01; 
    x_result_sel_csr =  1'b0;
    x_result_sel_sext =  1'b0;
    x_result_sel_logic =  1'b0;
    x_result_sel_add =  1'b0;
    if (op_rcsr)
        x_result_sel_csr =  1'b1;
    else if (sext)
        x_result_sel_sext =  1'b1;
    else if (logical) 
        x_result_sel_logic =  1'b1;
    else 
        x_result_sel_add =  1'b1;        
    m_result_sel_compare = cmp;
    m_result_sel_shift = shift;
    w_result_sel_load = load;
    w_result_sel_mul = op_mul; 
end
assign x_bypass_enable =  arith 
                        | logical
                        | sext 
                        | op_rcsr
                        ;
assign m_bypass_enable = x_bypass_enable 
                        | shift
                        | cmp
                        ;
assign read_enable_0 = ~(op_bi | op_calli);
assign read_idx_0 = instruction[25:21];
assign read_enable_1 = ~(op_bi | op_calli | load);
assign read_idx_1 = instruction[20:16];
assign write_enable = ~(bra | op_raise | store | op_wcsr);
assign write_idx = call
                    ? 5'd29
                    : instruction[31] == 1'b0 
                        ? instruction[20:16] 
                        : instruction[15:11];
assign size = instruction[27:26];
assign sign_extend = instruction[28];                      
assign adder_op = op_sub | op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne | bra;
assign logic_op = instruction[29:26];
assign direction = instruction[29];
assign branch = bra | call;
assign branch_reg = op_call | op_b;
assign condition = instruction[28:26];      
assign scall = op_raise & instruction[2];
assign eret = op_b & (instruction[25:21] == 5'd30);
assign csr_write_enable = op_wcsr;
assign sign_extend_immediate = ~(op_and | op_cmpgeu | op_cmpgu | op_nor | op_or | op_xnor | op_xor);
assign select_high_immediate = op_andhi | op_orhi;
assign select_call_immediate = instruction[31];
assign high_immediate = {instruction[15:0], 16'h0000};
assign extended_immediate = {{16{sign_extend_immediate & instruction[15]}}, instruction[15:0]};
assign call_immediate = {{6{instruction[25]}}, instruction[25:0]};
assign branch_immediate = {{16{instruction[15]}}, instruction[15:0]};
assign immediate = select_high_immediate ==  1'b1 
                        ? high_immediate 
                        : extended_immediate;
assign branch_offset = select_call_immediate ==  1'b1   
                        ? (call_immediate[ (32-2)-1:0])
                        : (branch_immediate[ (32-2)-1:0]);
endmodule 
module lm32_instruction_unit_medium (
    clk_i,
    rst_i,
    stall_a,
    stall_f,
    stall_d,
    stall_x,
    stall_m,
    valid_f,
    valid_d,
    kill_f,
    branch_predict_taken_d,
    branch_predict_address_d,
    exception_m,
    branch_taken_m,
    branch_mispredict_taken_m,
    branch_target_m,
    i_dat_i,
    i_ack_i,
    i_err_i,
    i_rty_i,
    pc_f,
    pc_d,
    pc_x,
    pc_m,
    pc_w,
    i_dat_o,
    i_adr_o,
    i_cyc_o,
    i_sel_o,
    i_stb_o,
    i_we_o,
    i_cti_o,
    i_lock_o,
    i_bte_o,
    instruction_f,
    instruction_d
    );
parameter eba_reset =  32'h00000000;                   
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam eba_reset_minus_4 = eba_reset - 4;
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_f;                                          
input stall_d;                                          
input stall_x;                                          
input stall_m;                                          
input valid_f;                                          
input valid_d;                                          
input kill_f;                                           
input branch_predict_taken_d;                           
input [ ((32-2)+2-1):2] branch_predict_address_d;          
input exception_m;
input branch_taken_m;                                   
input branch_mispredict_taken_m;                        
input [ ((32-2)+2-1):2] branch_target_m;                   
input [ (32-1):0] i_dat_i;                         
input i_ack_i;                                          
input i_err_i;                                          
input i_rty_i;                                          
output [ ((32-2)+2-1):2] pc_f;                             
reg    [ ((32-2)+2-1):2] pc_f;
output [ ((32-2)+2-1):2] pc_d;                             
reg    [ ((32-2)+2-1):2] pc_d;
output [ ((32-2)+2-1):2] pc_x;                             
reg    [ ((32-2)+2-1):2] pc_x;
output [ ((32-2)+2-1):2] pc_m;                             
reg    [ ((32-2)+2-1):2] pc_m;
output [ ((32-2)+2-1):2] pc_w;                             
reg    [ ((32-2)+2-1):2] pc_w;
output [ (32-1):0] i_dat_o;                        
wire   [ (32-1):0] i_dat_o;
output [ (32-1):0] i_adr_o;                        
reg    [ (32-1):0] i_adr_o;
output i_cyc_o;                                         
reg    i_cyc_o; 
output [ (4-1):0] i_sel_o;                 
wire   [ (4-1):0] i_sel_o;
output i_stb_o;                                         
reg    i_stb_o;
output i_we_o;                                          
wire   i_we_o;
output [ (3-1):0] i_cti_o;                       
reg    [ (3-1):0] i_cti_o;
output i_lock_o;                                        
reg    i_lock_o;
output [ (2-1):0] i_bte_o;                       
wire   [ (2-1):0] i_bte_o;
output [ (32-1):0] instruction_f;           
wire   [ (32-1):0] instruction_f;
output [ (32-1):0] instruction_d;           
reg    [ (32-1):0] instruction_d;
reg [ ((32-2)+2-1):2] pc_a;                                
reg [ (32-1):0] wb_data_f;                  
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
always @(*)
begin
      if (branch_taken_m ==  1'b1)
	if ((branch_mispredict_taken_m ==  1'b1) && (exception_m ==  1'b0))
	  pc_a = pc_x;
	else
          pc_a = branch_target_m;
      else
	if ( (valid_d ==  1'b1) && (branch_predict_taken_d ==  1'b1) )
	  pc_a = branch_predict_address_d;
	else
            pc_a = pc_f + 1'b1;
end
assign instruction_f = wb_data_f;
assign i_dat_o = 32'd0;
assign i_we_o =  1'b0;
assign i_sel_o = 4'b1111;
assign i_bte_o =  2'b00;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        pc_f <= eba_reset_minus_4[ ((32-2)+2-1):2];
        pc_d <= { (32-2){1'b0}};
        pc_x <= { (32-2){1'b0}};
        pc_m <= { (32-2){1'b0}};
        pc_w <= { (32-2){1'b0}};
    end
    else
    begin
        if (stall_f ==  1'b0)
            pc_f <= pc_a;
        if (stall_d ==  1'b0)
            pc_d <= pc_f;
        if (stall_x ==  1'b0)
            pc_x <= pc_d;
        if (stall_m ==  1'b0)
            pc_m <= pc_x;
        pc_w <= pc_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        i_cyc_o <=  1'b0;
        i_stb_o <=  1'b0;
        i_adr_o <= { 32{1'b0}};
        i_cti_o <=  3'b111;
        i_lock_o <=  1'b0;
        wb_data_f <= { 32{1'b0}};
    end
    else
    begin   
        if (i_cyc_o ==  1'b1)
        begin
            if((i_ack_i ==  1'b1) || (i_err_i ==  1'b1))
            begin
                i_cyc_o <=  1'b0;
                i_stb_o <=  1'b0;
                wb_data_f <= i_dat_i;
            end
        end
        else
        begin
            if (   (stall_a ==  1'b0) 
               )
            begin
                i_adr_o <= {pc_a, 2'b00};
                i_cyc_o <=  1'b1;
                i_stb_o <=  1'b1;
            end
	    else
	    begin
	        if (   (stall_a ==  1'b0) 
	           )
		begin
		end
	    end
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        instruction_d <= { 32{1'b0}};
    end
    else
    begin
        if (stall_d ==  1'b0)
        begin
            instruction_d <= instruction_f;
        end
    end
end  
endmodule
module lm32_interrupt_medium (
    clk_i, 
    rst_i,
    interrupt,
    stall_x,
    exception,
    eret_q_x,
    csr,
    csr_write_data,
    csr_write_enable,
    interrupt_exception,
    csr_read_data
    );
parameter interrupts =  32;         
input clk_i;                                    
input rst_i;                                    
input [interrupts-1:0] interrupt;               
input stall_x;                                  
input exception;                                
input eret_q_x;                                 
input [ (4 -1):0] csr;                      
input [ (32-1):0] csr_write_data;          
input csr_write_enable;                         
output interrupt_exception;                     
wire   interrupt_exception;
output [ (32-1):0] csr_read_data;          
reg    [ (32-1):0] csr_read_data;
wire [interrupts-1:0] asserted;                 
wire [interrupts-1:0] interrupt_n_exception;
reg ie;                                         
reg eie;                                        
reg [interrupts-1:0] ip;                        
reg [interrupts-1:0] im;                        
assign interrupt_n_exception = ip & im;
assign interrupt_exception = (|interrupt_n_exception) & ie;
assign asserted = ip | interrupt;
generate
    if (interrupts > 1) 
    begin
always @(*)
begin
    case (csr)
     4 'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    1'b0,                                     
                                    eie, 
                                    ie
                                   };
     4 'h2:  csr_read_data = ip;
     4 'h1:  csr_read_data = im;
    default:       csr_read_data = { 32{1'bx}};
    endcase
end
    end
    else
    begin
always @(*)
begin
    case (csr)
     4 'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    1'b0,                                    
                                    eie, 
                                    ie
                                   };
     4 'h2:  csr_read_data = ip;
    default:       csr_read_data = { 32{1'bx}};
      endcase
end
    end
endgenerate
   reg [ 10:0] eie_delay  = 0;
generate
    if (interrupts > 1)
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie                   <=  1'b0;
        eie                  <=  1'b0;
        im                   <= {interrupts{1'b0}};
        ip                   <= {interrupts{1'b0}};
       eie_delay             <= 0;
    end
    else
    begin
        ip                   <= asserted;
        if (exception ==  1'b1)
        begin
            eie              <= ie;
            ie               <=  1'b0;
        end
        else if (stall_x ==  1'b0)
        begin
           if(eie_delay[0])
             ie              <= eie;
           eie_delay         <= {1'b0, eie_delay[ 10:1]};
            if (eret_q_x ==  1'b1) begin
               eie_delay[ 10] <=  1'b1;
               eie_delay[ 10-1:0] <= 0;
            end
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  4 'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                end
                if (csr ==  4 'h1)
                    im  <= csr_write_data[interrupts-1:0];
                if (csr ==  4 'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
else
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie              <=  1'b0;
        eie             <=  1'b0;
        ip              <= {interrupts{1'b0}};
       eie_delay        <= 0;
    end
    else
    begin
        ip              <= asserted;
        if (exception ==  1'b1)
        begin
            eie         <= ie;
            ie          <=  1'b0;
        end
        else if (stall_x ==  1'b0)
          begin
             if(eie_delay[0])
               ie              <= eie;
             eie_delay         <= {1'b0, eie_delay[ 10:1]};
             if (eret_q_x ==  1'b1) begin
                eie_delay[ 10] <=  1'b1;
                eie_delay[ 10-1:0] <= 0;
             end
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  4 'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                end
                if (csr ==  4 'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
endgenerate
endmodule
module lm32_top_medium_debug (
    clk_i,
    rst_i,
    interrupt,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset = 32'h00000000;
parameter sdb_address = 32'h00000000;
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
wire [ 7:0] jtag_reg_d;
wire [ 7:0] jtag_reg_q;
wire jtag_update;
wire [2:0] jtag_reg_addr_d;
wire [2:0] jtag_reg_addr_q;
wire jtck;
wire jrstn;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_cpu_medium_debug 
	#(
		.eba_reset(eba_reset),
    .sdb_address(sdb_address)
	) cpu (
    .clk_i                 (clk_i),
    .rst_i                 (rst_i),
    .interrupt             (interrupt),
    .jtag_clk              (jtck),
    .jtag_update           (jtag_update),
    .jtag_reg_q            (jtag_reg_q),
    .jtag_reg_addr_q       (jtag_reg_addr_q),
    .I_DAT_I               (I_DAT_I),
    .I_ACK_I               (I_ACK_I),
    .I_ERR_I               (I_ERR_I),
    .I_RTY_I               (I_RTY_I),
    .D_DAT_I               (D_DAT_I),
    .D_ACK_I               (D_ACK_I),
    .D_ERR_I               (D_ERR_I),
    .D_RTY_I               (D_RTY_I),
    .jtag_reg_d            (jtag_reg_d),
    .jtag_reg_addr_d       (jtag_reg_addr_d),
    .I_DAT_O               (I_DAT_O),
    .I_ADR_O               (I_ADR_O),
    .I_CYC_O               (I_CYC_O),
    .I_SEL_O               (I_SEL_O),
    .I_STB_O               (I_STB_O),
    .I_WE_O                (I_WE_O),
    .I_CTI_O               (I_CTI_O),
    .I_LOCK_O              (I_LOCK_O),
    .I_BTE_O               (I_BTE_O),
    .D_DAT_O               (D_DAT_O),
    .D_ADR_O               (D_ADR_O),
    .D_CYC_O               (D_CYC_O),
    .D_SEL_O               (D_SEL_O),
    .D_STB_O               (D_STB_O),
    .D_WE_O                (D_WE_O),
    .D_CTI_O               (D_CTI_O),
    .D_LOCK_O              (D_LOCK_O),
    .D_BTE_O               (D_BTE_O)
    );
jtag_cores jtag_cores (
    .reg_d                 (jtag_reg_d),
    .reg_addr_d            (jtag_reg_addr_d),
    .reg_update            (jtag_update),
    .reg_q                 (jtag_reg_q),
    .reg_addr_q            (jtag_reg_addr_q),
    .jtck                  (jtck),
    .jrstn                 (jrstn)
    );
endmodule
module lm32_mc_arithmetic_medium_debug (
    clk_i,
    rst_i,
    stall_d,
    kill_x,
    operand_0_d,
    operand_1_d,
    result_x,
    stall_request_x
    );
input clk_i;                                    
input rst_i;                                    
input stall_d;                                  
input kill_x;                                   
input [ (32-1):0] operand_0_d;
input [ (32-1):0] operand_1_d;
output [ (32-1):0] result_x;               
reg    [ (32-1):0] result_x;
output stall_request_x;                         
wire   stall_request_x;
reg [ (32-1):0] p;                         
reg [ (32-1):0] a;
reg [ (32-1):0] b;
reg [ 2:0] state;                 
reg [5:0] cycles;                               
assign stall_request_x = state !=  3'b000;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        cycles <= {6{1'b0}};
        p <= { 32{1'b0}};
        a <= { 32{1'b0}};
        b <= { 32{1'b0}};
        result_x <= { 32{1'b0}};
        state <=  3'b000;
    end
    else
    begin
        case (state)
         3'b000:
        begin
            if (stall_d ==  1'b0)                 
            begin          
                cycles <=  32;
                p <= 32'b0;
                a <= operand_0_d;
                b <= operand_1_d;                    
            end            
        end
        endcase
    end
end 
endmodule
module lm32_cpu_medium_debug (
    clk_i,
    rst_i,
    interrupt,
    jtag_clk,
    jtag_update, 
    jtag_reg_q,
    jtag_reg_addr_q,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    jtag_reg_d,
    jtag_reg_addr_d,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset =  32'h00000000;                           
parameter deba_reset =  32'h10000000;                         
parameter sdb_address =   32'h00000000;
parameter icache_associativity =  1;     
parameter icache_sets =  256;                       
parameter icache_bytes_per_line =  16;   
parameter icache_base_address =  32'h0;       
parameter icache_limit =  32'h7fffffff;                     
parameter dcache_associativity = 1;    
parameter dcache_sets = 512;                      
parameter dcache_bytes_per_line = 16;  
parameter dcache_base_address = 0;      
parameter dcache_limit = 0;                    
parameter watchpoints =  32'h4;                       
parameter breakpoints = 0;
parameter interrupts =  32;                         
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input jtag_clk;                                 
input jtag_update;                              
input [ 7:0] jtag_reg_q;              
input [2:0] jtag_reg_addr_q;
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ 7:0] jtag_reg_d;
wire   [ 7:0] jtag_reg_d;
output [2:0] jtag_reg_addr_d;
wire   [2:0] jtag_reg_addr_d;
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
reg valid_a;                                    
reg valid_f;                                    
reg valid_d;                                    
reg valid_x;                                    
reg valid_m;                                    
reg valid_w;                                    
wire q_x;
wire [ (32-1):0] immediate_d;              
wire load_d;                                    
reg load_x;                                     
reg load_m;
wire load_q_x;
wire store_q_x;
wire q_m;
wire load_q_m;
wire store_q_m;
wire store_d;                                   
reg store_x;
reg store_m;
wire [ 1:0] size_d;                   
reg [ 1:0] size_x;
wire branch_d;                                  
wire branch_predict_d;                          
wire branch_predict_taken_d;                    
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_predict_address_d;   
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_d;
wire bi_unconditional;
wire bi_conditional;
reg branch_x;                                   
reg branch_predict_x;
reg branch_predict_taken_x;
reg branch_m;
reg branch_predict_m;
reg branch_predict_taken_m;
wire branch_mispredict_taken_m;                 
wire branch_flushX_m;                           
wire branch_reg_d;                              
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset_d;            
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_x;             
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_m;
wire [ 0:0] d_result_sel_0_d; 
wire [ 1:0] d_result_sel_1_d; 
wire x_result_sel_csr_d;                        
reg x_result_sel_csr_x;
wire x_result_sel_sext_d;                       
reg x_result_sel_sext_x;
wire x_result_sel_logic_d;                      
wire x_result_sel_add_d;                        
reg x_result_sel_add_x;
wire m_result_sel_compare_d;                    
reg m_result_sel_compare_x;
reg m_result_sel_compare_m;
wire m_result_sel_shift_d;                      
reg m_result_sel_shift_x;
reg m_result_sel_shift_m;
wire w_result_sel_load_d;                       
reg w_result_sel_load_x;
reg w_result_sel_load_m;
reg w_result_sel_load_w;
wire w_result_sel_mul_d;                        
reg w_result_sel_mul_x;
reg w_result_sel_mul_m;
reg w_result_sel_mul_w;
wire x_bypass_enable_d;                         
reg x_bypass_enable_x;                          
wire m_bypass_enable_d;                         
reg m_bypass_enable_x;                          
reg m_bypass_enable_m;
wire sign_extend_d;                             
reg sign_extend_x;
wire write_enable_d;                            
reg write_enable_x;
wire write_enable_q_x;
reg write_enable_m;
wire write_enable_q_m;
reg write_enable_w;
wire write_enable_q_w;
wire read_enable_0_d;                           
wire [ (5-1):0] read_idx_0_d;          
wire read_enable_1_d;                           
wire [ (5-1):0] read_idx_1_d;          
wire [ (5-1):0] write_idx_d;           
reg [ (5-1):0] write_idx_x;            
reg [ (5-1):0] write_idx_m;
reg [ (5-1):0] write_idx_w;
wire [ (5-1):0] csr_d;                     
reg  [ (5-1):0] csr_x;                  
wire [ (3-1):0] condition_d;         
reg [ (3-1):0] condition_x;          
wire break_d;                                   
reg break_x;                                    
wire scall_d;                                   
reg scall_x;    
wire eret_d;                                    
reg eret_x;
wire eret_q_x;
wire bret_d;                                    
reg bret_x;
wire bret_q_x;
wire csr_write_enable_d;                        
reg csr_write_enable_x;
wire csr_write_enable_q_x;
reg [ (32-1):0] d_result_0;                
reg [ (32-1):0] d_result_1;                
reg [ (32-1):0] x_result;                  
reg [ (32-1):0] m_result;                  
reg [ (32-1):0] w_result;                  
reg [ (32-1):0] operand_0_x;               
reg [ (32-1):0] operand_1_x;               
reg [ (32-1):0] store_operand_x;           
reg [ (32-1):0] operand_m;                 
reg [ (32-1):0] operand_w;                 
reg [ (32-1):0] reg_data_live_0;          
reg [ (32-1):0] reg_data_live_1;  
reg use_buf;                                    
reg [ (32-1):0] reg_data_buf_0;
reg [ (32-1):0] reg_data_buf_1;
wire [ (32-1):0] reg_data_0;               
wire [ (32-1):0] reg_data_1;               
reg [ (32-1):0] bypass_data_0;             
reg [ (32-1):0] bypass_data_1;             
wire reg_write_enable_q_w;
reg interlock;                                  
wire stall_a;                                   
wire stall_f;                                   
wire stall_d;                                   
wire stall_x;                                   
wire stall_m;                                   
wire adder_op_d;                                
reg adder_op_x;                                 
reg adder_op_x_n;                               
wire [ (32-1):0] adder_result_x;           
wire adder_overflow_x;                          
wire adder_carry_n_x;                           
wire [ 3:0] logic_op_d;           
reg [ 3:0] logic_op_x;            
wire [ (32-1):0] logic_result_x;           
wire [ (32-1):0] sextb_result_x;           
wire [ (32-1):0] sexth_result_x;           
wire [ (32-1):0] sext_result_x;            
wire direction_d;                               
reg direction_x;                                        
wire [ (32-1):0] shifter_result_m;         
wire [ (32-1):0] multiplier_result_w;      
wire [ (32-1):0] interrupt_csr_read_data_x;
wire [ (32-1):0] cfg;                      
wire [ (32-1):0] cfg2;                     
reg [ (32-1):0] csr_read_data_x;           
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;                       
wire [ (32-1):0] instruction_f;     
wire [ (32-1):0] instruction_d;     
wire iflush;                                    
wire icache_stall_request;                      
wire icache_restart_request;                    
wire icache_refill_request;                     
wire icache_refilling;                          
wire [ (32-1):0] load_data_w;              
wire stall_wb_load;                             
wire [ (32-1):0] jtx_csr_read_data;        
wire [ (32-1):0] jrx_csr_read_data;        
wire jtag_csr_write_enable;                     
wire [ (32-1):0] jtag_csr_write_data;      
wire [ (5-1):0] jtag_csr;                  
wire jtag_read_enable;                          
wire [ 7:0] jtag_read_data;
wire jtag_write_enable;
wire [ 7:0] jtag_write_data;
wire [ (32-1):0] jtag_address;
wire jtag_access_complete;
wire jtag_break;                                
wire raw_x_0;                                   
wire raw_x_1;                                   
wire raw_m_0;                                   
wire raw_m_1;                                   
wire raw_w_0;                                   
wire raw_w_1;                                   
wire cmp_zero;                                  
wire cmp_negative;                              
wire cmp_overflow;                              
wire cmp_carry_n;                               
reg condition_met_x;                            
reg condition_met_m;
wire branch_taken_m;                            
wire kill_f;                                    
wire kill_d;                                    
wire kill_x;                                    
wire kill_m;                                    
wire kill_w;                                    
reg [ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8] eba;                 
reg [ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8] deba;                
reg [ (3-1):0] eid_x;                      
wire dc_ss;                                     
wire dc_re;                                     
wire bp_match;
wire wp_match;
wire exception_x;                               
reg exception_m;                                
wire debug_exception_x;                         
reg debug_exception_m;
reg debug_exception_w;
wire debug_exception_q_w;
wire non_debug_exception_x;                     
reg non_debug_exception_m;
reg non_debug_exception_w;
wire non_debug_exception_q_w;
wire reset_exception;                           
wire interrupt_exception;                       
wire breakpoint_exception;                      
wire watchpoint_exception;                      
wire system_call_exception;                     
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_instruction_unit_medium_debug #(
    .eba_reset              (eba_reset),
    .associativity          (icache_associativity),
    .sets                   (icache_sets),
    .bytes_per_line         (icache_bytes_per_line),
    .base_address           (icache_base_address),
    .limit                  (icache_limit)
  ) instruction_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_f                (stall_f),
    .stall_d                (stall_d),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .valid_f                (valid_f),
    .valid_d                (valid_d),
    .kill_f                 (kill_f),
    .branch_predict_taken_d (branch_predict_taken_d),
    .branch_predict_address_d (branch_predict_address_d),
    .exception_m            (exception_m),
    .branch_taken_m         (branch_taken_m),
    .branch_mispredict_taken_m (branch_mispredict_taken_m),
    .branch_target_m        (branch_target_m),
    .iflush                 (iflush),
    .i_dat_i                (I_DAT_I),
    .i_ack_i                (I_ACK_I),
    .i_err_i                (I_ERR_I),
    .i_rty_i                (I_RTY_I),
    .jtag_read_enable       (jtag_read_enable),
    .jtag_write_enable      (jtag_write_enable),
    .jtag_write_data        (jtag_write_data),
    .jtag_address           (jtag_address),
    .pc_f                   (pc_f),
    .pc_d                   (pc_d),
    .pc_x                   (pc_x),
    .pc_m                   (pc_m),
    .pc_w                   (pc_w),
    .icache_stall_request   (icache_stall_request),
    .icache_restart_request (icache_restart_request),
    .icache_refill_request  (icache_refill_request),
    .icache_refilling       (icache_refilling),
    .i_dat_o                (I_DAT_O),
    .i_adr_o                (I_ADR_O),
    .i_cyc_o                (I_CYC_O),
    .i_sel_o                (I_SEL_O),
    .i_stb_o                (I_STB_O),
    .i_we_o                 (I_WE_O),
    .i_cti_o                (I_CTI_O),
    .i_lock_o               (I_LOCK_O),
    .i_bte_o                (I_BTE_O),
    .jtag_read_data         (jtag_read_data),
    .jtag_access_complete   (jtag_access_complete),
    .instruction_f          (instruction_f),
    .instruction_d          (instruction_d)
    );
lm32_decoder_medium_debug decoder (
    .instruction            (instruction_d),
    .d_result_sel_0         (d_result_sel_0_d),
    .d_result_sel_1         (d_result_sel_1_d),
    .x_result_sel_csr       (x_result_sel_csr_d),
    .x_result_sel_sext      (x_result_sel_sext_d),
    .x_result_sel_logic     (x_result_sel_logic_d),
    .x_result_sel_add       (x_result_sel_add_d),
    .m_result_sel_compare   (m_result_sel_compare_d),
    .m_result_sel_shift     (m_result_sel_shift_d),  
    .w_result_sel_load      (w_result_sel_load_d),
    .w_result_sel_mul       (w_result_sel_mul_d),
    .x_bypass_enable        (x_bypass_enable_d),
    .m_bypass_enable        (m_bypass_enable_d),
    .read_enable_0          (read_enable_0_d),
    .read_idx_0             (read_idx_0_d),
    .read_enable_1          (read_enable_1_d),
    .read_idx_1             (read_idx_1_d),
    .write_enable           (write_enable_d),
    .write_idx              (write_idx_d),
    .immediate              (immediate_d),
    .branch_offset          (branch_offset_d),
    .load                   (load_d),
    .store                  (store_d),
    .size                   (size_d),
    .sign_extend            (sign_extend_d),
    .adder_op               (adder_op_d),
    .logic_op               (logic_op_d),
    .direction              (direction_d),
    .branch                 (branch_d),
    .bi_unconditional       (bi_unconditional),
    .bi_conditional         (bi_conditional),
    .branch_reg             (branch_reg_d),
    .condition              (condition_d),
    .break_opcode           (break_d),
    .scall                  (scall_d),
    .eret                   (eret_d),
    .bret                   (bret_d),
    .csr_write_enable       (csr_write_enable_d)
    ); 
lm32_load_store_unit_medium_debug #(
    .associativity          (dcache_associativity),
    .sets                   (dcache_sets),
    .bytes_per_line         (dcache_bytes_per_line),
    .base_address           (dcache_base_address),
    .limit                  (dcache_limit)
  ) load_store_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .kill_x                 (kill_x),
    .kill_m                 (kill_m),
    .exception_m            (exception_m),
    .store_operand_x        (store_operand_x),
    .load_store_address_x   (adder_result_x),
    .load_store_address_m   (operand_m),
    .load_store_address_w   (operand_w[1:0]),
    .load_x                 (load_x),
    .store_x                (store_x),
    .load_q_x               (load_q_x),
    .store_q_x              (store_q_x),
    .load_q_m               (load_q_m),
    .store_q_m              (store_q_m),
    .sign_extend_x          (sign_extend_x),
    .size_x                 (size_x),
    .d_dat_i                (D_DAT_I),
    .d_ack_i                (D_ACK_I),
    .d_err_i                (D_ERR_I),
    .d_rty_i                (D_RTY_I),
    .load_data_w            (load_data_w),
    .stall_wb_load          (stall_wb_load),
    .d_dat_o                (D_DAT_O),
    .d_adr_o                (D_ADR_O),
    .d_cyc_o                (D_CYC_O),
    .d_sel_o                (D_SEL_O),
    .d_stb_o                (D_STB_O),
    .d_we_o                 (D_WE_O),
    .d_cti_o                (D_CTI_O),
    .d_lock_o               (D_LOCK_O),
    .d_bte_o                (D_BTE_O)
    );      
lm32_adder adder (
    .adder_op_x             (adder_op_x),
    .adder_op_x_n           (adder_op_x_n),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .adder_result_x         (adder_result_x),
    .adder_carry_n_x        (adder_carry_n_x),
    .adder_overflow_x       (adder_overflow_x)
    );
lm32_logic_op logic_op (
    .logic_op_x             (logic_op_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .logic_result_x         (logic_result_x)
    );
lm32_shifter shifter (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .direction_x            (direction_x),
    .sign_extend_x          (sign_extend_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .shifter_result_m       (shifter_result_m)
    );
lm32_multiplier multiplier (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .operand_0              (d_result_0),
    .operand_1              (d_result_1),
    .result                 (multiplier_result_w)    
    );
lm32_interrupt_medium_debug interrupt_unit (
    .clk_i                  (clk_i), 
    .rst_i                  (rst_i),
    .interrupt              (interrupt),
    .stall_x                (stall_x),
    .non_debug_exception    (non_debug_exception_q_w), 
    .debug_exception        (debug_exception_q_w),
    .eret_q_x               (eret_q_x),
    .bret_q_x               (bret_q_x),
    .csr                    (csr_x),
    .csr_write_data         (operand_1_x),
    .csr_write_enable       (csr_write_enable_q_x),
    .interrupt_exception    (interrupt_exception),
    .csr_read_data          (interrupt_csr_read_data_x)
    );
lm32_jtag_medium_debug jtag (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .jtag_clk               (jtag_clk),
    .jtag_update            (jtag_update),
    .jtag_reg_q             (jtag_reg_q),
    .jtag_reg_addr_q        (jtag_reg_addr_q),
    .csr                    (csr_x),
    .csr_write_data         (operand_1_x),
    .csr_write_enable       (csr_write_enable_q_x),
    .stall_x                (stall_x),
    .jtag_read_data         (jtag_read_data),
    .jtag_access_complete   (jtag_access_complete),
    .exception_q_w          (debug_exception_q_w || non_debug_exception_q_w),
    .jtx_csr_read_data      (jtx_csr_read_data),
    .jrx_csr_read_data      (jrx_csr_read_data),
    .jtag_csr_write_enable  (jtag_csr_write_enable),
    .jtag_csr_write_data    (jtag_csr_write_data),
    .jtag_csr               (jtag_csr),
    .jtag_read_enable       (jtag_read_enable),
    .jtag_write_enable      (jtag_write_enable),
    .jtag_write_data        (jtag_write_data),
    .jtag_address           (jtag_address),
    .jtag_break             (jtag_break),
    .jtag_reset             (reset_exception),
    .jtag_reg_d             (jtag_reg_d),
    .jtag_reg_addr_d        (jtag_reg_addr_d)
    );
lm32_debug_medium_debug #(
    .breakpoints            (breakpoints),
    .watchpoints            (watchpoints)
  ) hw_debug (
    .clk_i                  (clk_i), 
    .rst_i                  (rst_i),
    .pc_x                   (pc_x),
    .load_x                 (load_x),
    .store_x                (store_x),
    .load_store_address_x   (adder_result_x),
    .csr_write_enable_x     (csr_write_enable_q_x),
    .csr_write_data         (operand_1_x),
    .csr_x                  (csr_x),
    .jtag_csr_write_enable  (jtag_csr_write_enable),
    .jtag_csr_write_data    (jtag_csr_write_data),
    .jtag_csr               (jtag_csr),
    .eret_q_x               (eret_q_x),
    .bret_q_x               (bret_q_x),
    .stall_x                (stall_x),
    .exception_x            (exception_x),
    .q_x                    (q_x),
    .dc_ss                  (dc_ss),
    .dc_re                  (dc_re),
    .bp_match               (bp_match),
    .wp_match               (wp_match)
    );
   wire [31:0] regfile_data_0, regfile_data_1;
   reg [31:0]  w_result_d;
   reg 	       regfile_raw_0, regfile_raw_0_nxt;
   reg 	       regfile_raw_1, regfile_raw_1_nxt;
   always @(reg_write_enable_q_w or write_idx_w or instruction_f)
     begin
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[25:21]))
	  regfile_raw_0_nxt = 1'b1;
	else
	  regfile_raw_0_nxt = 1'b0;
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[20:16]))
	  regfile_raw_1_nxt = 1'b1;
	else
	  regfile_raw_1_nxt = 1'b0;
     end
   always @(regfile_raw_0 or w_result_d or regfile_data_0)
     if (regfile_raw_0)
       reg_data_live_0 = w_result_d;
     else
       reg_data_live_0 = regfile_data_0;
   always @(regfile_raw_1 or w_result_d or regfile_data_1)
     if (regfile_raw_1)
       reg_data_live_1 = w_result_d;
     else
       reg_data_live_1 = regfile_data_1;
   always @(posedge clk_i  )
     if (rst_i ==  1'b1)
       begin
	  regfile_raw_0 <= 1'b0;
	  regfile_raw_1 <= 1'b0;
	  w_result_d <= 32'b0;
       end
     else
       begin
	  regfile_raw_0 <= regfile_raw_0_nxt;
	  regfile_raw_1 <= regfile_raw_1_nxt;
	  w_result_d <= w_result;
       end
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_0
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[25:21]),
      .rdata_o	(regfile_data_0)
      );
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_1
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[20:16]),
      .rdata_o	(regfile_data_1)
      );
assign reg_data_0 = use_buf ? reg_data_buf_0 : reg_data_live_0;
assign reg_data_1 = use_buf ? reg_data_buf_1 : reg_data_live_1;
assign raw_x_0 = (write_idx_x == read_idx_0_d) && (write_enable_q_x ==  1'b1);
assign raw_m_0 = (write_idx_m == read_idx_0_d) && (write_enable_q_m ==  1'b1);
assign raw_w_0 = (write_idx_w == read_idx_0_d) && (write_enable_q_w ==  1'b1);
assign raw_x_1 = (write_idx_x == read_idx_1_d) && (write_enable_q_x ==  1'b1);
assign raw_m_1 = (write_idx_m == read_idx_1_d) && (write_enable_q_m ==  1'b1);
assign raw_w_1 = (write_idx_w == read_idx_1_d) && (write_enable_q_w ==  1'b1);
always @(*)
begin
    if (   (   (x_bypass_enable_x ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_x_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_x_1 ==  1'b1))
               )
           )
        || (   (m_bypass_enable_m ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_m_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_m_1 ==  1'b1))
               )
           )
       )
        interlock =  1'b1;
    else
        interlock =  1'b0;
end
always @(*)
begin
    if (raw_x_0 ==  1'b1)        
        bypass_data_0 = x_result;
    else if (raw_m_0 ==  1'b1)
        bypass_data_0 = m_result;
    else if (raw_w_0 ==  1'b1)
        bypass_data_0 = w_result;
    else
        bypass_data_0 = reg_data_0;
end
always @(*)
begin
    if (raw_x_1 ==  1'b1)
        bypass_data_1 = x_result;
    else if (raw_m_1 ==  1'b1)
        bypass_data_1 = m_result;
    else if (raw_w_1 ==  1'b1)
        bypass_data_1 = w_result;
    else
        bypass_data_1 = reg_data_1;
end
   assign branch_predict_d = bi_unconditional | bi_conditional;
   assign branch_predict_taken_d = bi_unconditional ? 1'b1 : (bi_conditional ? instruction_d[15] : 1'b0);
   assign branch_target_d = pc_d + branch_offset_d;
   assign branch_predict_address_d = branch_predict_taken_d ? branch_target_d : pc_f;
always @(*)
begin
    d_result_0 = d_result_sel_0_d[0] ? {pc_f, 2'b00} : bypass_data_0; 
    case (d_result_sel_1_d)
     2'b00:      d_result_1 = { 32{1'b0}};
     2'b01:     d_result_1 = bypass_data_1;
     2'b10: d_result_1 = immediate_d;
    default:                        d_result_1 = { 32{1'bx}};
    endcase
end
assign sextb_result_x = {{24{operand_0_x[7]}}, operand_0_x[7:0]};
assign sexth_result_x = {{16{operand_0_x[15]}}, operand_0_x[15:0]};
assign sext_result_x = size_x ==  2'b00 ? sextb_result_x : sexth_result_x;
assign cmp_zero = operand_0_x == operand_1_x;
assign cmp_negative = adder_result_x[ 32-1];
assign cmp_overflow = adder_overflow_x;
assign cmp_carry_n = adder_carry_n_x;
always @(*)
begin
    case (condition_x)
     3'b000:   condition_met_x =  1'b1;
     3'b110:   condition_met_x =  1'b1;
     3'b001:    condition_met_x = cmp_zero;
     3'b111:   condition_met_x = !cmp_zero;
     3'b010:    condition_met_x = !cmp_zero && (cmp_negative == cmp_overflow);
     3'b101:   condition_met_x = cmp_carry_n && !cmp_zero;
     3'b011:   condition_met_x = cmp_negative == cmp_overflow;
     3'b100:  condition_met_x = cmp_carry_n;
    default:              condition_met_x = 1'bx;
    endcase 
end
always @(*)
begin
    x_result =   x_result_sel_add_x ? adder_result_x 
               : x_result_sel_csr_x ? csr_read_data_x
               : x_result_sel_sext_x ? sext_result_x
               : logic_result_x;
end
always @(*)
begin
    m_result =   m_result_sel_compare_m ? {{ 32-1{1'b0}}, condition_met_m}
               : m_result_sel_shift_m ? shifter_result_m
               : operand_m; 
end
always @(*)
begin
    w_result =    w_result_sel_load_w ? load_data_w
                : w_result_sel_mul_w ? multiplier_result_w
                : operand_w;
end
assign branch_taken_m =      (stall_m ==  1'b0) 
                          && (   (   (branch_m ==  1'b1) 
                                  && (valid_m ==  1'b1)
                                  && (   (   (condition_met_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b0)
					 )
				      || (   (condition_met_m ==  1'b0)
					  && (branch_predict_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b1)
					 )
				     )
                                 ) 
                              || (exception_m ==  1'b1)
                             );
assign branch_mispredict_taken_m =    (condition_met_m ==  1'b0)
                                   && (branch_predict_m ==  1'b1)
	   			   && (branch_predict_taken_m ==  1'b1);
assign branch_flushX_m =    (stall_m ==  1'b0)
                         && (   (   (branch_m ==  1'b1) 
                                 && (valid_m ==  1'b1)
			         && (   (condition_met_m ==  1'b1)
				     || (   (condition_met_m ==  1'b0)
					 && (branch_predict_m ==  1'b1)
					 && (branch_predict_taken_m ==  1'b1)
					)
				    )
			        )
			     || (exception_m ==  1'b1)
			    );
assign kill_f =    (   (valid_d ==  1'b1)
                    && (branch_predict_taken_d ==  1'b1)
		   )
                || (branch_taken_m ==  1'b1) 
                || (icache_refill_request ==  1'b1) 
                ;
assign kill_d =    (branch_taken_m ==  1'b1) 
                || (icache_refill_request ==  1'b1)     
                ;
assign kill_x =    (branch_flushX_m ==  1'b1) 
                ;
assign kill_m =     1'b0
                ;                
assign kill_w =     1'b0
                ;
assign breakpoint_exception =    (   (   (break_x ==  1'b1)
				      || (bp_match ==  1'b1)
				     )
				  && (valid_x ==  1'b1)
				 )
                              || (jtag_break ==  1'b1)
                              ;
assign watchpoint_exception = wp_match ==  1'b1;
assign system_call_exception = (   (scall_x ==  1'b1)
			       );
assign debug_exception_x =  (breakpoint_exception ==  1'b1)
                         || (watchpoint_exception ==  1'b1)
                         ;
assign non_debug_exception_x = (system_call_exception ==  1'b1)
                            || (reset_exception ==  1'b1)
                            || (   (interrupt_exception ==  1'b1)
                                && (dc_ss ==  1'b0)
                               )
                            ;
assign exception_x = (debug_exception_x ==  1'b1) || (non_debug_exception_x ==  1'b1);
always @(*)
begin
    if (reset_exception ==  1'b1)
        eid_x =  3'h0;
    else
         if (breakpoint_exception ==  1'b1)
        eid_x =  3'd1;
    else
         if (watchpoint_exception ==  1'b1)
        eid_x =  3'd3;
    else 
         if (   (interrupt_exception ==  1'b1)
             && (dc_ss ==  1'b0)
            )
        eid_x =  3'h6;
    else
        eid_x =  3'h7;
end
assign stall_a = (stall_f ==  1'b1);
assign stall_f = (stall_d ==  1'b1);
assign stall_d =   (stall_x ==  1'b1) 
                || (   (interlock ==  1'b1)
                    && (kill_d ==  1'b0)
                   ) 
		|| (   (   (eret_d ==  1'b1)
			|| (scall_d ==  1'b1)
		       )
		    && (   (load_q_x ==  1'b1)
			|| (load_q_m ==  1'b1)
			|| (store_q_x ==  1'b1)
			|| (store_q_m ==  1'b1)
			|| (D_CYC_O ==  1'b1)
		       )
                    && (kill_d ==  1'b0)
		   )
		|| (   (   (break_d ==  1'b1)
			|| (bret_d ==  1'b1)
		       )
		    && (   (load_q_x ==  1'b1)
			|| (store_q_x ==  1'b1)
			|| (load_q_m ==  1'b1)
			|| (store_q_m ==  1'b1)
			|| (D_CYC_O ==  1'b1)
		       )
                    && (kill_d ==  1'b0)
		   )
                || (   (csr_write_enable_d ==  1'b1)
                    && (load_q_x ==  1'b1)
                   )                      
                ;
assign stall_x =    (stall_m ==  1'b1)
                 ;
assign stall_m =    (stall_wb_load ==  1'b1)
                 || (   (D_CYC_O ==  1'b1)
                     && (   (store_m ==  1'b1)
		         || ((store_x ==  1'b1) && (interrupt_exception ==  1'b1))
                         || (load_m ==  1'b1)
                         || (load_x ==  1'b1)
                        ) 
                    ) 
                 || (icache_stall_request ==  1'b1)     
                 || ((I_CYC_O ==  1'b1) && ((branch_m ==  1'b1) || (exception_m ==  1'b1))) 
                 ;      
assign q_x = (valid_x ==  1'b1) && (kill_x ==  1'b0);
assign csr_write_enable_q_x = (csr_write_enable_x ==  1'b1) && (q_x ==  1'b1);
assign eret_q_x = (eret_x ==  1'b1) && (q_x ==  1'b1);
assign bret_q_x = (bret_x ==  1'b1) && (q_x ==  1'b1);
assign load_q_x = (load_x ==  1'b1) 
               && (q_x ==  1'b1)
               && (bp_match ==  1'b0)
                  ;
assign store_q_x = (store_x ==  1'b1) 
               && (q_x ==  1'b1)
               && (bp_match ==  1'b0)
                  ;
assign q_m = (valid_m ==  1'b1) && (kill_m ==  1'b0) && (exception_m ==  1'b0);
assign load_q_m = (load_m ==  1'b1) && (q_m ==  1'b1);
assign store_q_m = (store_m ==  1'b1) && (q_m ==  1'b1);
assign debug_exception_q_w = ((debug_exception_w ==  1'b1) && (valid_w ==  1'b1));
assign non_debug_exception_q_w = ((non_debug_exception_w ==  1'b1) && (valid_w ==  1'b1));        
assign write_enable_q_x = (write_enable_x ==  1'b1) && (valid_x ==  1'b1) && (branch_flushX_m ==  1'b0);
assign write_enable_q_m = (write_enable_m ==  1'b1) && (valid_m ==  1'b1);
assign write_enable_q_w = (write_enable_w ==  1'b1) && (valid_w ==  1'b1);
assign reg_write_enable_q_w = (write_enable_w ==  1'b1) && (kill_w ==  1'b0) && (valid_w ==  1'b1);
assign cfg = {
               6'h02,
              watchpoints[3:0],
              breakpoints[3:0],
              interrupts[5:0],
               1'b1,
               1'b0,
               1'b1,
               1'b1,
               1'b1,
               1'b0,
               1'b0,
               1'b0,
               1'b1,
               1'b1,
               1'b0,
               1'b1
              };
assign cfg2 = {
		     30'b0,
		      1'b0,
		      1'b0
		     };
assign iflush = (   (csr_write_enable_d ==  1'b1) 
                 && (csr_d ==  5'h3)
                 && (stall_d ==  1'b0)
                 && (kill_d ==  1'b0)
                 && (valid_d ==  1'b1))
             ||
                (   (jtag_csr_write_enable ==  1'b1)
		 && (jtag_csr ==  5'h3))
		 ;
assign csr_d = read_idx_0_d[ (5-1):0];
always @(*)
begin
    case (csr_x)
     5'h0,
     5'h1,
     5'h2:   csr_read_data_x = interrupt_csr_read_data_x;  
     5'h6:  csr_read_data_x = cfg;
     5'h7:  csr_read_data_x = {eba, 8'h00};
     5'h9: csr_read_data_x = {deba, 8'h00};
     5'he:  csr_read_data_x = jtx_csr_read_data;  
     5'hf:  csr_read_data_x = jrx_csr_read_data;
     5'ha: csr_read_data_x = cfg2;
     5'hb:  csr_read_data_x = sdb_address;
    default:        csr_read_data_x = { 32{1'bx}};
    endcase
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        eba <= eba_reset[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    else
    begin
        if ((csr_write_enable_q_x ==  1'b1) && (csr_x ==  5'h7) && (stall_x ==  1'b0))
            eba <= operand_1_x[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
        if ((jtag_csr_write_enable ==  1'b1) && (jtag_csr ==  5'h7))
            eba <= jtag_csr_write_data[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        deba <= deba_reset[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    else
    begin
        if ((csr_write_enable_q_x ==  1'b1) && (csr_x ==  5'h9) && (stall_x ==  1'b0))
            deba <= operand_1_x[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
        if ((jtag_csr_write_enable ==  1'b1) && (jtag_csr ==  5'h9))
            deba <= jtag_csr_write_data[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    end
end
always @(*)
begin
    if (icache_refill_request ==  1'b1) 
        valid_a =  1'b0;
    else if (icache_restart_request ==  1'b1) 
        valid_a =  1'b1;
    else 
        valid_a = !icache_refilling;
end 
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        valid_f <=  1'b0;
        valid_d <=  1'b0;
        valid_x <=  1'b0;
        valid_m <=  1'b0;
        valid_w <=  1'b0;
    end
    else
    begin    
        if ((kill_f ==  1'b1) || (stall_a ==  1'b0))
            valid_f <= valid_a;    
        else if (stall_f ==  1'b0)
            valid_f <=  1'b0;            
        if (kill_d ==  1'b1)
            valid_d <=  1'b0;
        else if (stall_f ==  1'b0)
            valid_d <= valid_f & !kill_f;
        else if (stall_d ==  1'b0)
            valid_d <=  1'b0;
        if (stall_d ==  1'b0)
            valid_x <= valid_d & !kill_d;
        else if (kill_x ==  1'b1)
            valid_x <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_x <=  1'b0;
        if (kill_m ==  1'b1)
            valid_m <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_m <= valid_x & !kill_x;
        else if (stall_m ==  1'b0)
            valid_m <=  1'b0;
        if (stall_m ==  1'b0)
            valid_w <= valid_m & !kill_m;
        else 
            valid_w <=  1'b0;        
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        operand_0_x <= { 32{1'b0}};
        operand_1_x <= { 32{1'b0}};
        store_operand_x <= { 32{1'b0}};
        branch_target_x <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};        
        x_result_sel_csr_x <=  1'b0;
        x_result_sel_sext_x <=  1'b0;
        x_result_sel_add_x <=  1'b0;
        m_result_sel_compare_x <=  1'b0;
        m_result_sel_shift_x <=  1'b0;
        w_result_sel_load_x <=  1'b0;
        w_result_sel_mul_x <=  1'b0;
        x_bypass_enable_x <=  1'b0;
        m_bypass_enable_x <=  1'b0;
        write_enable_x <=  1'b0;
        write_idx_x <= { 5{1'b0}};
        csr_x <= { 5{1'b0}};
        load_x <=  1'b0;
        store_x <=  1'b0;
        size_x <= { 2{1'b0}};
        sign_extend_x <=  1'b0;
        adder_op_x <=  1'b0;
        adder_op_x_n <=  1'b0;
        logic_op_x <= 4'h0;
        direction_x <=  1'b0;
        branch_x <=  1'b0;
        branch_predict_x <=  1'b0;
        branch_predict_taken_x <=  1'b0;
        condition_x <=  3'b000;
        break_x <=  1'b0;
        scall_x <=  1'b0;
        eret_x <=  1'b0;
        bret_x <=  1'b0;
        csr_write_enable_x <=  1'b0;
        operand_m <= { 32{1'b0}};
        branch_target_m <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        m_result_sel_compare_m <=  1'b0;
        m_result_sel_shift_m <=  1'b0;
        w_result_sel_load_m <=  1'b0;
        w_result_sel_mul_m <=  1'b0;
        m_bypass_enable_m <=  1'b0;
        branch_m <=  1'b0;
        branch_predict_m <=  1'b0;
	branch_predict_taken_m <=  1'b0;
        exception_m <=  1'b0;
        load_m <=  1'b0;
        store_m <=  1'b0;
        write_enable_m <=  1'b0;            
        write_idx_m <= { 5{1'b0}};
        condition_met_m <=  1'b0;
        debug_exception_m <=  1'b0;
        non_debug_exception_m <=  1'b0;        
        operand_w <= { 32{1'b0}};        
        w_result_sel_load_w <=  1'b0;
        w_result_sel_mul_w <=  1'b0;
        write_idx_w <= { 5{1'b0}};        
        write_enable_w <=  1'b0;
        debug_exception_w <=  1'b0;
        non_debug_exception_w <=  1'b0;        
    end
    else
    begin
        if (stall_x ==  1'b0)
        begin
            operand_0_x <= d_result_0;
            operand_1_x <= d_result_1;
            store_operand_x <= bypass_data_1;
            branch_target_x <= branch_reg_d ==  1'b1 ? bypass_data_0[ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] : branch_target_d;            
            x_result_sel_csr_x <= x_result_sel_csr_d;
            x_result_sel_sext_x <= x_result_sel_sext_d;
            x_result_sel_add_x <= x_result_sel_add_d;
            m_result_sel_compare_x <= m_result_sel_compare_d;
            m_result_sel_shift_x <= m_result_sel_shift_d;
            w_result_sel_load_x <= w_result_sel_load_d;
            w_result_sel_mul_x <= w_result_sel_mul_d;
            x_bypass_enable_x <= x_bypass_enable_d;
            m_bypass_enable_x <= m_bypass_enable_d;
            load_x <= load_d;
            store_x <= store_d;
            branch_x <= branch_d;
	    branch_predict_x <= branch_predict_d;
	    branch_predict_taken_x <= branch_predict_taken_d;
	    write_idx_x <= write_idx_d;
            csr_x <= csr_d;
            size_x <= size_d;
            sign_extend_x <= sign_extend_d;
            adder_op_x <= adder_op_d;
            adder_op_x_n <= ~adder_op_d;
            logic_op_x <= logic_op_d;
            direction_x <= direction_d;
            condition_x <= condition_d;
            csr_write_enable_x <= csr_write_enable_d;
            break_x <= break_d;
            scall_x <= scall_d;
            eret_x <= eret_d;
            bret_x <= bret_d; 
            write_enable_x <= write_enable_d;
        end
        if (stall_m ==  1'b0)
        begin
            operand_m <= x_result;
            m_result_sel_compare_m <= m_result_sel_compare_x;
            m_result_sel_shift_m <= m_result_sel_shift_x;
            if (exception_x ==  1'b1)
            begin
                w_result_sel_load_m <=  1'b0;
                w_result_sel_mul_m <=  1'b0;
            end
            else
            begin
                w_result_sel_load_m <= w_result_sel_load_x;
                w_result_sel_mul_m <= w_result_sel_mul_x;
            end
            m_bypass_enable_m <= m_bypass_enable_x;
            load_m <= load_x;
            store_m <= store_x;
            branch_m <= branch_x;
	    branch_predict_m <= branch_predict_x;
	    branch_predict_taken_m <= branch_predict_taken_x;
            if (non_debug_exception_x ==  1'b1) 
                write_idx_m <=  5'd30;
            else if (debug_exception_x ==  1'b1)
                write_idx_m <=  5'd31;
            else 
                write_idx_m <= write_idx_x;
            condition_met_m <= condition_met_x;
	   if (exception_x ==  1'b1)
	     if ((dc_re ==  1'b1)
		 || ((debug_exception_x ==  1'b1) 
		     && (non_debug_exception_x ==  1'b0)))
	       branch_target_m <= {deba, eid_x, {3{1'b0}}};
	     else
	       branch_target_m <= {eba, eid_x, {3{1'b0}}};
	   else
	     branch_target_m <= branch_target_x;
            write_enable_m <= exception_x ==  1'b1 ?  1'b1 : write_enable_x;            
            debug_exception_m <= debug_exception_x;
            non_debug_exception_m <= non_debug_exception_x;        
        end
        if (stall_m ==  1'b0)
        begin
            if ((exception_x ==  1'b1) && (q_x ==  1'b1) && (stall_x ==  1'b0))
                exception_m <=  1'b1;
            else 
                exception_m <=  1'b0;
	end
        operand_w <= exception_m ==  1'b1 ? {pc_m, 2'b00} : m_result;
        w_result_sel_load_w <= w_result_sel_load_m;
        w_result_sel_mul_w <= w_result_sel_mul_m;
        write_idx_w <= write_idx_m;
        write_enable_w <= write_enable_m;
        debug_exception_w <= debug_exception_m;
        non_debug_exception_w <= non_debug_exception_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        use_buf <=  1'b0;
        reg_data_buf_0 <= { 32{1'b0}};
        reg_data_buf_1 <= { 32{1'b0}};
    end
    else
    begin
        if (stall_d ==  1'b0)
            use_buf <=  1'b0;
        else if (use_buf ==  1'b0)
        begin        
            reg_data_buf_0 <= reg_data_live_0;
            reg_data_buf_1 <= reg_data_live_1;
            use_buf <=  1'b1;
        end        
        if (reg_write_enable_q_w ==  1'b1)
        begin
            if (write_idx_w == read_idx_0_d)
                reg_data_buf_0 <= w_result;
            if (write_idx_w == read_idx_1_d)
                reg_data_buf_1 <= w_result;
        end
    end
end
initial
begin
end
endmodule 
module lm32_load_store_unit_medium_debug (
    clk_i,
    rst_i,
    stall_a,
    stall_x,
    stall_m,
    kill_x,
    kill_m,
    exception_m,
    store_operand_x,
    load_store_address_x,
    load_store_address_m,
    load_store_address_w,
    load_x,
    store_x,
    load_q_x,
    store_q_x,
    load_q_m,
    store_q_m,
    sign_extend_x,
    size_x,
    d_dat_i,
    d_ack_i,
    d_err_i,
    d_rty_i,
    load_data_w,
    stall_wb_load,
    d_dat_o,
    d_adr_o,
    d_cyc_o,
    d_sel_o,
    d_stb_o,
    d_we_o,
    d_cti_o,
    d_lock_o,
    d_bte_o
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_x;                                          
input stall_m;                                          
input kill_x;                                           
input kill_m;                                           
input exception_m;                                      
input [ (32-1):0] store_operand_x;                 
input [ (32-1):0] load_store_address_x;            
input [ (32-1):0] load_store_address_m;            
input [1:0] load_store_address_w;                       
input load_x;                                           
input store_x;                                          
input load_q_x;                                         
input store_q_x;                                        
input load_q_m;                                         
input store_q_m;                                        
input sign_extend_x;                                    
input [ 1:0] size_x;                          
input [ (32-1):0] d_dat_i;                         
input d_ack_i;                                          
input d_err_i;                                          
input d_rty_i;                                          
output [ (32-1):0] load_data_w;                    
reg    [ (32-1):0] load_data_w;
output stall_wb_load;                                   
reg    stall_wb_load;
output [ (32-1):0] d_dat_o;                        
reg    [ (32-1):0] d_dat_o;
output [ (32-1):0] d_adr_o;                        
reg    [ (32-1):0] d_adr_o;
output d_cyc_o;                                         
reg    d_cyc_o;
output [ (4-1):0] d_sel_o;                 
reg    [ (4-1):0] d_sel_o;
output d_stb_o;                                         
reg    d_stb_o; 
output d_we_o;                                          
reg    d_we_o;
output [ (3-1):0] d_cti_o;                       
reg    [ (3-1):0] d_cti_o;
output d_lock_o;                                        
reg    d_lock_o;
output [ (2-1):0] d_bte_o;                       
wire   [ (2-1):0] d_bte_o;
reg [ 1:0] size_m;
reg [ 1:0] size_w;
reg sign_extend_m;
reg sign_extend_w;
reg [ (32-1):0] store_data_x;       
reg [ (32-1):0] store_data_m;       
reg [ (4-1):0] byte_enable_x;
reg [ (4-1):0] byte_enable_m;
wire [ (32-1):0] data_m;
reg [ (32-1):0] data_w;
wire wb_select_x;                                       
reg wb_select_m;
reg [ (32-1):0] wb_data_m;                         
reg wb_load_complete;                                   
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
   assign wb_select_x =     1'b1
                     ;
always @(*)
begin
    case (size_x)
     2'b00:  store_data_x = {4{store_operand_x[7:0]}};
     2'b11: store_data_x = {2{store_operand_x[15:0]}};
     2'b10:  store_data_x = store_operand_x;    
    default:          store_data_x = { 32{1'bx}};
    endcase
end
always @(*)
begin
    casez ({size_x, load_store_address_x[1:0]})
    { 2'b00, 2'b11}:  byte_enable_x = 4'b0001;
    { 2'b00, 2'b10}:  byte_enable_x = 4'b0010;
    { 2'b00, 2'b01}:  byte_enable_x = 4'b0100;
    { 2'b00, 2'b00}:  byte_enable_x = 4'b1000;
    { 2'b11, 2'b1?}: byte_enable_x = 4'b0011;
    { 2'b11, 2'b0?}: byte_enable_x = 4'b1100;
    { 2'b10, 2'b??}:  byte_enable_x = 4'b1111;
    default:                   byte_enable_x = 4'bxxxx;
    endcase
end
   assign data_m = wb_data_m;
always @(*)
begin
    casez ({size_w, load_store_address_w[1:0]})
    { 2'b00, 2'b11}:  load_data_w = {{24{sign_extend_w & data_w[7]}}, data_w[7:0]};
    { 2'b00, 2'b10}:  load_data_w = {{24{sign_extend_w & data_w[15]}}, data_w[15:8]};
    { 2'b00, 2'b01}:  load_data_w = {{24{sign_extend_w & data_w[23]}}, data_w[23:16]};
    { 2'b00, 2'b00}:  load_data_w = {{24{sign_extend_w & data_w[31]}}, data_w[31:24]};
    { 2'b11, 2'b1?}: load_data_w = {{16{sign_extend_w & data_w[15]}}, data_w[15:0]};
    { 2'b11, 2'b0?}: load_data_w = {{16{sign_extend_w & data_w[31]}}, data_w[31:16]};
    { 2'b10, 2'b??}:  load_data_w = data_w;
    default:                   load_data_w = { 32{1'bx}};
    endcase
end
assign d_bte_o =  2'b00;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        d_cyc_o <=  1'b0;
        d_stb_o <=  1'b0;
        d_dat_o <= { 32{1'b0}};
        d_adr_o <= { 32{1'b0}};
        d_sel_o <= { 4{ 1'b0}};
        d_we_o <=  1'b0;
        d_cti_o <=  3'b111;
        d_lock_o <=  1'b0;
        wb_data_m <= { 32{1'b0}};
        wb_load_complete <=  1'b0;
        stall_wb_load <=  1'b0;
    end
    else
    begin
        if (d_cyc_o ==  1'b1)
        begin
            if ((d_ack_i ==  1'b1) || (d_err_i ==  1'b1))
            begin
                begin
                    d_cyc_o <=  1'b0;
                    d_stb_o <=  1'b0;
                    d_lock_o <=  1'b0;
                end
                wb_data_m <= d_dat_i;
                wb_load_complete <= !d_we_o;
            end
            if (d_err_i ==  1'b1)
                $display ("Data bus error. Address: %x", d_adr_o);
        end
        else
        begin
                 if (   (store_q_m ==  1'b1)
                     && (stall_m ==  1'b0)
                    )
            begin
                d_dat_o <= store_data_m;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b1;
                d_cti_o <=  3'b111;
            end        
            else if (   (load_q_m ==  1'b1) 
                     && (wb_select_m ==  1'b1) 
                     && (wb_load_complete ==  1'b0)
                    )
            begin
                stall_wb_load <=  1'b0;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b0;
                d_cti_o <=  3'b111;
            end
        end
        if (stall_m ==  1'b0)
            wb_load_complete <=  1'b0;
        if ((load_q_x ==  1'b1) && (wb_select_x ==  1'b1) && (stall_x ==  1'b0))
            stall_wb_load <=  1'b1;
        if ((kill_m ==  1'b1) || (exception_m ==  1'b1))
            stall_wb_load <=  1'b0;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        sign_extend_m <=  1'b0;
        size_m <= 2'b00;
        byte_enable_m <=  1'b0;
        store_data_m <= { 32{1'b0}};
        wb_select_m <=  1'b0;        
    end
    else
    begin
        if (stall_m ==  1'b0)
        begin
            sign_extend_m <= sign_extend_x;
            size_m <= size_x;
            byte_enable_m <= byte_enable_x;    
            store_data_m <= store_data_x;
            wb_select_m <= wb_select_x;
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        size_w <= 2'b00;
        data_w <= { 32{1'b0}};
        sign_extend_w <=  1'b0;
    end
    else
    begin
        size_w <= size_m;
        data_w <= data_m;
        sign_extend_w <= sign_extend_m;
    end
end
always @(posedge clk_i)
begin
    if (((load_q_m ==  1'b1) || (store_q_m ==  1'b1)) && (stall_m ==  1'b0)) 
    begin
        if ((size_m ===  2'b11) && (load_store_address_m[0] !== 1'b0))
            $display ("Warning: Non-aligned halfword access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
        if ((size_m ===  2'b10) && (load_store_address_m[1:0] !== 2'b00))
            $display ("Warning: Non-aligned word access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
    end
end
endmodule
module lm32_decoder_medium_debug (
    instruction,
    d_result_sel_0,
    d_result_sel_1,        
    x_result_sel_csr,
    x_result_sel_sext,
    x_result_sel_logic,
    x_result_sel_add,
    m_result_sel_compare,
    m_result_sel_shift,  
    w_result_sel_load,
    w_result_sel_mul,
    x_bypass_enable,
    m_bypass_enable,
    read_enable_0,
    read_idx_0,
    read_enable_1,
    read_idx_1,
    write_enable,
    write_idx,
    immediate,
    branch_offset,
    load,
    store,
    size,
    sign_extend,
    adder_op,
    logic_op,
    direction,
    branch,
    branch_reg,
    condition,
    bi_conditional,
    bi_unconditional,
    break_opcode,
    scall,
    eret,
    bret,
    csr_write_enable
    );
input [ (32-1):0] instruction;       
output [ 0:0] d_result_sel_0;
reg    [ 0:0] d_result_sel_0;
output [ 1:0] d_result_sel_1;
reg    [ 1:0] d_result_sel_1;
output x_result_sel_csr;
reg    x_result_sel_csr;
output x_result_sel_sext;
reg    x_result_sel_sext;
output x_result_sel_logic;
reg    x_result_sel_logic;
output x_result_sel_add;
reg    x_result_sel_add;
output m_result_sel_compare;
reg    m_result_sel_compare;
output m_result_sel_shift;
reg    m_result_sel_shift;
output w_result_sel_load;
reg    w_result_sel_load;
output w_result_sel_mul;
reg    w_result_sel_mul;
output x_bypass_enable;
wire   x_bypass_enable;
output m_bypass_enable;
wire   m_bypass_enable;
output read_enable_0;
wire   read_enable_0;
output [ (5-1):0] read_idx_0;
wire   [ (5-1):0] read_idx_0;
output read_enable_1;
wire   read_enable_1;
output [ (5-1):0] read_idx_1;
wire   [ (5-1):0] read_idx_1;
output write_enable;
wire   write_enable;
output [ (5-1):0] write_idx;
wire   [ (5-1):0] write_idx;
output [ (32-1):0] immediate;
wire   [ (32-1):0] immediate;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset;
wire   [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset;
output load;
wire   load;
output store;
wire   store;
output [ 1:0] size;
wire   [ 1:0] size;
output sign_extend;
wire   sign_extend;
output adder_op;
wire   adder_op;
output [ 3:0] logic_op;
wire   [ 3:0] logic_op;
output direction;
wire   direction;
output branch;
wire   branch;
output branch_reg;
wire   branch_reg;
output [ (3-1):0] condition;
wire   [ (3-1):0] condition;
output bi_conditional;
wire bi_conditional;
output bi_unconditional;
wire bi_unconditional;
output break_opcode;
wire   break_opcode;
output scall;
wire   scall;
output eret;
wire   eret;
output bret;
wire   bret;
output csr_write_enable;
wire   csr_write_enable;
wire [ (32-1):0] extended_immediate;       
wire [ (32-1):0] high_immediate;           
wire [ (32-1):0] call_immediate;           
wire [ (32-1):0] branch_immediate;         
wire sign_extend_immediate;                     
wire select_high_immediate;                     
wire select_call_immediate;                     
wire op_add;
wire op_and;
wire op_andhi;
wire op_b;
wire op_bi;
wire op_be;
wire op_bg;
wire op_bge;
wire op_bgeu;
wire op_bgu;
wire op_bne;
wire op_call;
wire op_calli;
wire op_cmpe;
wire op_cmpg;
wire op_cmpge;
wire op_cmpgeu;
wire op_cmpgu;
wire op_cmpne;
wire op_lb;
wire op_lbu;
wire op_lh;
wire op_lhu;
wire op_lw;
wire op_mul;
wire op_nor;
wire op_or;
wire op_orhi;
wire op_raise;
wire op_rcsr;
wire op_sb;
wire op_sextb;
wire op_sexth;
wire op_sh;
wire op_sl;
wire op_sr;
wire op_sru;
wire op_sub;
wire op_sw;
wire op_wcsr;
wire op_xnor;
wire op_xor;
wire arith;
wire logical;
wire cmp;
wire bra;
wire call;
wire shift;
wire sext;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
assign op_add    = instruction[ 30:26] ==  5'b01101;
assign op_and    = instruction[ 30:26] ==  5'b01000;
assign op_andhi  = instruction[ 31:26] ==  6'b011000;
assign op_b      = instruction[ 31:26] ==  6'b110000;
assign op_bi     = instruction[ 31:26] ==  6'b111000;
assign op_be     = instruction[ 31:26] ==  6'b010001;
assign op_bg     = instruction[ 31:26] ==  6'b010010;
assign op_bge    = instruction[ 31:26] ==  6'b010011;
assign op_bgeu   = instruction[ 31:26] ==  6'b010100;
assign op_bgu    = instruction[ 31:26] ==  6'b010101;
assign op_bne    = instruction[ 31:26] ==  6'b010111;
assign op_call   = instruction[ 31:26] ==  6'b110110;
assign op_calli  = instruction[ 31:26] ==  6'b111110;
assign op_cmpe   = instruction[ 30:26] ==  5'b11001;
assign op_cmpg   = instruction[ 30:26] ==  5'b11010;
assign op_cmpge  = instruction[ 30:26] ==  5'b11011;
assign op_cmpgeu = instruction[ 30:26] ==  5'b11100;
assign op_cmpgu  = instruction[ 30:26] ==  5'b11101;
assign op_cmpne  = instruction[ 30:26] ==  5'b11111;
assign op_lb     = instruction[ 31:26] ==  6'b000100;
assign op_lbu    = instruction[ 31:26] ==  6'b010000;
assign op_lh     = instruction[ 31:26] ==  6'b000111;
assign op_lhu    = instruction[ 31:26] ==  6'b001011;
assign op_lw     = instruction[ 31:26] ==  6'b001010;
assign op_mul    = instruction[ 30:26] ==  5'b00010;
assign op_nor    = instruction[ 30:26] ==  5'b00001;
assign op_or     = instruction[ 30:26] ==  5'b01110;
assign op_orhi   = instruction[ 31:26] ==  6'b011110;
assign op_raise  = instruction[ 31:26] ==  6'b101011;
assign op_rcsr   = instruction[ 31:26] ==  6'b100100;
assign op_sb     = instruction[ 31:26] ==  6'b001100;
assign op_sextb  = instruction[ 31:26] ==  6'b101100;
assign op_sexth  = instruction[ 31:26] ==  6'b110111;
assign op_sh     = instruction[ 31:26] ==  6'b000011;
assign op_sl     = instruction[ 30:26] ==  5'b01111;      
assign op_sr     = instruction[ 30:26] ==  5'b00101;
assign op_sru    = instruction[ 30:26] ==  5'b00000;
assign op_sub    = instruction[ 31:26] ==  6'b110010;
assign op_sw     = instruction[ 31:26] ==  6'b010110;
assign op_wcsr   = instruction[ 31:26] ==  6'b110100;
assign op_xnor   = instruction[ 30:26] ==  5'b01001;
assign op_xor    = instruction[ 30:26] ==  5'b00110;
assign arith = op_add | op_sub;
assign logical = op_and | op_andhi | op_nor | op_or | op_orhi | op_xor | op_xnor;
assign cmp = op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne;
assign bi_conditional = op_be | op_bg | op_bge | op_bgeu  | op_bgu | op_bne;
assign bi_unconditional = op_bi;
assign bra = op_b | bi_unconditional | bi_conditional;
assign call = op_call | op_calli;
assign shift = op_sl | op_sr | op_sru;
assign sext = op_sextb | op_sexth;
assign load = op_lb | op_lbu | op_lh | op_lhu | op_lw;
assign store = op_sb | op_sh | op_sw;
always @(*)
begin
    if (call) 
        d_result_sel_0 =  1'b1;
    else 
        d_result_sel_0 =  1'b0;
    if (call) 
        d_result_sel_1 =  2'b00;         
    else if ((instruction[31] == 1'b0) && !bra) 
        d_result_sel_1 =  2'b10;
    else
        d_result_sel_1 =  2'b01; 
    x_result_sel_csr =  1'b0;
    x_result_sel_sext =  1'b0;
    x_result_sel_logic =  1'b0;
    x_result_sel_add =  1'b0;
    if (op_rcsr)
        x_result_sel_csr =  1'b1;
    else if (sext)
        x_result_sel_sext =  1'b1;
    else if (logical) 
        x_result_sel_logic =  1'b1;
    else 
        x_result_sel_add =  1'b1;        
    m_result_sel_compare = cmp;
    m_result_sel_shift = shift;
    w_result_sel_load = load;
    w_result_sel_mul = op_mul; 
end
assign x_bypass_enable =  arith 
                        | logical
                        | sext 
                        | op_rcsr
                        ;
assign m_bypass_enable = x_bypass_enable 
                        | shift
                        | cmp
                        ;
assign read_enable_0 = ~(op_bi | op_calli);
assign read_idx_0 = instruction[25:21];
assign read_enable_1 = ~(op_bi | op_calli | load);
assign read_idx_1 = instruction[20:16];
assign write_enable = ~(bra | op_raise | store | op_wcsr);
assign write_idx = call
                    ? 5'd29
                    : instruction[31] == 1'b0 
                        ? instruction[20:16] 
                        : instruction[15:11];
assign size = instruction[27:26];
assign sign_extend = instruction[28];                      
assign adder_op = op_sub | op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne | bra;
assign logic_op = instruction[29:26];
assign direction = instruction[29];
assign branch = bra | call;
assign branch_reg = op_call | op_b;
assign condition = instruction[28:26];      
assign break_opcode = op_raise & ~instruction[2];
assign scall = op_raise & instruction[2];
assign eret = op_b & (instruction[25:21] == 5'd30);
assign bret = op_b & (instruction[25:21] == 5'd31);
assign csr_write_enable = op_wcsr;
assign sign_extend_immediate = ~(op_and | op_cmpgeu | op_cmpgu | op_nor | op_or | op_xnor | op_xor);
assign select_high_immediate = op_andhi | op_orhi;
assign select_call_immediate = instruction[31];
assign high_immediate = {instruction[15:0], 16'h0000};
assign extended_immediate = {{16{sign_extend_immediate & instruction[15]}}, instruction[15:0]};
assign call_immediate = {{6{instruction[25]}}, instruction[25:0]};
assign branch_immediate = {{16{instruction[15]}}, instruction[15:0]};
assign immediate = select_high_immediate ==  1'b1 
                        ? high_immediate 
                        : extended_immediate;
assign branch_offset = select_call_immediate ==  1'b1   
                        ? (call_immediate[ (clogb2(32'h7fffffff-32'h0)-2)-1:0])
                        : (branch_immediate[ (clogb2(32'h7fffffff-32'h0)-2)-1:0]);
endmodule 
module lm32_icache_medium_debug ( 
    clk_i,
    rst_i,    
    stall_a,
    stall_f,
    address_a,
    address_f,
    read_enable_f,
    refill_ready,
    refill_data,
    iflush,
    valid_d,
    branch_predict_taken_d,
    stall_request,
    restart_request,
    refill_request,
    refill_address,
    refilling,
    inst
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = clogb2(bytes_per_line)-1-2;
localparam addr_set_width = clogb2(sets)-1;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
localparam addr_set_lsb = (addr_offset_msb+1);
localparam addr_set_msb = (addr_set_lsb+addr_set_width-1);
localparam addr_tag_lsb = (addr_set_msb+1);
localparam addr_tag_msb = clogb2( 32'h7fffffff- 32'h0)-1;
localparam addr_tag_width = (addr_tag_msb-addr_tag_lsb+1);
input clk_i;                                        
input rst_i;                                        
input stall_a;                                      
input stall_f;                                      
input valid_d;                                      
input branch_predict_taken_d;                       
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] address_a;                     
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] address_f;                     
input read_enable_f;                                
input refill_ready;                                 
input [ (32-1):0] refill_data;          
input iflush;                                       
output stall_request;                               
wire   stall_request;
output restart_request;                             
reg    restart_request;
output refill_request;                              
wire   refill_request;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] refill_address;               
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] refill_address;               
output refilling;                                   
reg    refilling;
output [ (32-1):0] inst;                
wire   [ (32-1):0] inst;
wire enable;
wire [0:associativity-1] way_mem_we;
wire [ (32-1):0] way_data[0:associativity-1];
wire [ ((addr_tag_width+1)-1):1] way_tag[0:associativity-1];
wire [0:associativity-1] way_valid;
wire [0:associativity-1] way_match;
wire miss;
wire [ (addr_set_width-1):0] tmem_read_address;
wire [ (addr_set_width-1):0] tmem_write_address;
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_read_address;
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_write_address;
wire [ ((addr_tag_width+1)-1):0] tmem_write_data;
reg [ 3:0] state;
wire flushing;
wire check;
wire refill;
reg [associativity-1:0] refill_way_select;
reg [ addr_offset_msb:addr_offset_lsb] refill_offset;
wire last_refill;
reg [ (addr_set_width-1):0] flush_set;
genvar i;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
   generate
      for (i = 0; i < associativity; i = i + 1)
	begin : memories
	   lm32_ram 
	     #(
	       .data_width                 (32),
	       .address_width              ( (addr_offset_width+addr_set_width))
) 
	   way_0_data_ram 
	     (
	      .read_clk                   (clk_i),
	      .write_clk                  (clk_i),
	      .reset                      (rst_i),
	      .read_address               (dmem_read_address),
	      .enable_read                (enable),
	      .write_address              (dmem_write_address),
	      .enable_write               ( 1'b1),
	      .write_enable               (way_mem_we[i]),
	      .write_data                 (refill_data),    
	      .read_data                  (way_data[i])
	      );
	   lm32_ram 
	     #(
	       .data_width                 ( (addr_tag_width+1)),
	       .address_width              ( addr_set_width)
	       ) 
	   way_0_tag_ram 
	     (
	      .read_clk                   (clk_i),
	      .write_clk                  (clk_i),
	      .reset                      (rst_i),
	      .read_address               (tmem_read_address),
	      .enable_read                (enable),
	      .write_address              (tmem_write_address),
	      .enable_write               ( 1'b1),
	      .write_enable               (way_mem_we[i] | flushing),
	      .write_data                 (tmem_write_data),
	      .read_data                  ({way_tag[i], way_valid[i]})
	      );
	end
endgenerate
generate
    for (i = 0; i < associativity; i = i + 1)
    begin : match
assign way_match[i] = ({way_tag[i], way_valid[i]} == {address_f[ addr_tag_msb:addr_tag_lsb],  1'b1});
    end
endgenerate
generate
    if (associativity == 1)
    begin : inst_1
assign inst = way_match[0] ? way_data[0] : 32'b0;
    end
    else if (associativity == 2)
	 begin : inst_2
assign inst = way_match[0] ? way_data[0] : (way_match[1] ? way_data[1] : 32'b0);
    end
endgenerate
generate 
    if (bytes_per_line > 4)
assign dmem_write_address = {refill_address[ addr_set_msb:addr_set_lsb], refill_offset};
    else
assign dmem_write_address = refill_address[ addr_set_msb:addr_set_lsb];
endgenerate
assign dmem_read_address = address_a[ addr_set_msb:addr_offset_lsb];
assign tmem_read_address = address_a[ addr_set_msb:addr_set_lsb];
assign tmem_write_address = flushing 
                                ? flush_set
                                : refill_address[ addr_set_msb:addr_set_lsb];
generate 
    if (bytes_per_line > 4)                            
assign last_refill = refill_offset == {addr_offset_width{1'b1}};
    else
assign last_refill =  1'b1;
endgenerate
assign enable = (stall_a ==  1'b0);
generate
    if (associativity == 1) 
    begin : we_1     
assign way_mem_we[0] = (refill_ready ==  1'b1);
    end
    else
    begin : we_2
assign way_mem_we[0] = (refill_ready ==  1'b1) && (refill_way_select[0] ==  1'b1);
assign way_mem_we[1] = (refill_ready ==  1'b1) && (refill_way_select[1] ==  1'b1);
    end
endgenerate                     
assign tmem_write_data[ 0] = last_refill & !flushing;
assign tmem_write_data[ ((addr_tag_width+1)-1):1] = refill_address[ addr_tag_msb:addr_tag_lsb];
assign flushing = |state[1:0];
assign check = state[2];
assign refill = state[3];
assign miss = (~(|way_match)) && (read_enable_f ==  1'b1) && (stall_f ==  1'b0) && !(valid_d && branch_predict_taken_d);
assign stall_request = (check ==  1'b0);
assign refill_request = (refill ==  1'b1);
generate
    if (associativity >= 2) 
    begin : way_select      
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_way_select <= {{associativity-1{1'b0}}, 1'b1};
    else
    begin        
        if (miss ==  1'b1)
            refill_way_select <= {refill_way_select[0], refill_way_select[1]};
    end
end
    end
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refilling <=  1'b0;
    else
        refilling <= refill;
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        state <=  4'b0001;
        flush_set <= { addr_set_width{1'b1}};
        refill_address <= { (clogb2(32'h7fffffff-32'h0)-2){1'bx}};
        restart_request <=  1'b0;
    end
    else 
    begin
        case (state)
         4'b0001:
        begin            
            if (flush_set == { addr_set_width{1'b0}})
                state <=  4'b0100;
            flush_set <= flush_set - 1'b1;
        end
         4'b0010:
        begin            
            if (flush_set == { addr_set_width{1'b0}})
		state <=  4'b0100;
            flush_set <= flush_set - 1'b1;
        end
         4'b0100:
        begin            
            if (stall_a ==  1'b0)
                restart_request <=  1'b0;
            if (iflush ==  1'b1)
            begin
                refill_address <= address_f;
                state <=  4'b0010;
            end
            else if (miss ==  1'b1)
            begin
                refill_address <= address_f;
                state <=  4'b1000;
            end
        end
         4'b1000:
        begin            
            if (refill_ready ==  1'b1)
            begin
                if (last_refill ==  1'b1)
                begin
                    restart_request <=  1'b1;
                    state <=  4'b0100;
                end
            end
        end
        endcase        
    end
end
generate 
    if (bytes_per_line > 4)
    begin
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_offset <= {addr_offset_width{1'b0}};
    else 
    begin
        case (state)
         4'b0100:
        begin            
            if (iflush ==  1'b1)
                refill_offset <= {addr_offset_width{1'b0}};
            else if (miss ==  1'b1)
                refill_offset <= {addr_offset_width{1'b0}};
        end
         4'b1000:
        begin            
            if (refill_ready ==  1'b1)
                refill_offset <= refill_offset + 1'b1;
        end
        endcase        
    end
end
    end
endgenerate
endmodule
module lm32_debug_medium_debug (
    clk_i, 
    rst_i,
    pc_x,
    load_x,
    store_x,
    load_store_address_x,
    csr_write_enable_x,
    csr_write_data,
    csr_x,
    jtag_csr_write_enable,
    jtag_csr_write_data,
    jtag_csr,
    eret_q_x,
    bret_q_x,
    stall_x,
    exception_x,
    q_x,
    dc_ss,
    dc_re,
    bp_match,
    wp_match
    );
parameter breakpoints = 0;                      
parameter watchpoints = 0;                      
input clk_i;                                    
input rst_i;                                    
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;                      
input load_x;                                   
input store_x;                                  
input [ (32-1):0] load_store_address_x;    
input csr_write_enable_x;                       
input [ (32-1):0] csr_write_data;          
input [ (5-1):0] csr_x;                    
input jtag_csr_write_enable;                    
input [ (32-1):0] jtag_csr_write_data;     
input [ (5-1):0] jtag_csr;                 
input eret_q_x;                                 
input bret_q_x;                                 
input stall_x;                                  
input exception_x;                              
input q_x;                                      
output dc_ss;                                   
reg    dc_ss;
output dc_re;                                   
reg    dc_re;
output bp_match;                                
wire   bp_match;        
output wp_match;                                
wire   wp_match;
genvar i;                                       
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] bp_a[0:breakpoints-1];       
reg bp_e[0:breakpoints-1];                      
wire [0:breakpoints-1]bp_match_n;               
reg [ 1:0] wpc_c[0:watchpoints-1];   
reg [ (32-1):0] wp[0:watchpoints-1];       
wire [0:watchpoints-1]wp_match_n;               
wire debug_csr_write_enable;                    
wire [ (32-1):0] debug_csr_write_data;     
wire [ (5-1):0] debug_csr;                 
reg [ 2:0] state;           
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
generate
    for (i = 0; i < breakpoints; i = i + 1)
    begin : bp_comb
assign bp_match_n[i] = ((bp_a[i] == pc_x) && (bp_e[i] ==  1'b1));
    end
endgenerate
generate 
    if (breakpoints > 0) 
assign bp_match = (|bp_match_n) || (state ==  3'b011);
    else
assign bp_match = state ==  3'b011;
endgenerate    
generate 
    for (i = 0; i < watchpoints; i = i + 1)
    begin : wp_comb
assign wp_match_n[i] = (wp[i] == load_store_address_x) && ((load_x & wpc_c[i][0]) | (store_x & wpc_c[i][1]));
    end               
endgenerate
generate
    if (watchpoints > 0) 
assign wp_match = |wp_match_n;                
    else
assign wp_match =  1'b0;
endgenerate
assign debug_csr_write_enable = (csr_write_enable_x ==  1'b1) || (jtag_csr_write_enable ==  1'b1);
assign debug_csr_write_data = jtag_csr_write_enable ==  1'b1 ? jtag_csr_write_data : csr_write_data;
assign debug_csr = jtag_csr_write_enable ==  1'b1 ? jtag_csr : csr_x;
generate
    for (i = 0; i < breakpoints; i = i + 1)
    begin : bp_seq
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        bp_a[i] <= { (clogb2(32'h7fffffff-32'h0)-2){1'bx}};
        bp_e[i] <=  1'b0;
    end
    else
    begin
        if ((debug_csr_write_enable ==  1'b1) && (debug_csr ==  5'h10 + i))
        begin
            bp_a[i] <= debug_csr_write_data[ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2];
            bp_e[i] <= debug_csr_write_data[0];
        end
    end
end    
    end
endgenerate
generate
    for (i = 0; i < watchpoints; i = i + 1)
    begin : wp_seq
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        wp[i] <= { 32{1'bx}};
        wpc_c[i] <=  2'b00;
    end
    else
    begin
        if (debug_csr_write_enable ==  1'b1)
        begin
            if (debug_csr ==  5'h8)
                wpc_c[i] <= debug_csr_write_data[3+i*2:2+i*2];
            if (debug_csr ==  5'h18 + i)
                wp[i] <= debug_csr_write_data;
        end
    end  
end
    end
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        dc_re <=  1'b0;
    else
    begin
        if ((debug_csr_write_enable ==  1'b1) && (debug_csr ==  5'h8))
            dc_re <= debug_csr_write_data[1];
    end
end    
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        state <=  3'b000;
        dc_ss <=  1'b0;
    end
    else
    begin
        if ((debug_csr_write_enable ==  1'b1) && (debug_csr ==  5'h8))
        begin
            dc_ss <= debug_csr_write_data[0];
            if (debug_csr_write_data[0] ==  1'b0) 
                state <=  3'b000;
            else 
                state <=  3'b001;
        end
        case (state)
         3'b001:
        begin
            if (   (   (eret_q_x ==  1'b1)
                    || (bret_q_x ==  1'b1)
                    )
                && (stall_x ==  1'b0)
               )
                state <=  3'b010; 
        end
         3'b010:
        begin
            if ((q_x ==  1'b1) && (stall_x ==  1'b0))
                state <=  3'b011;
        end
         3'b011:
        begin
                 if ((exception_x ==  1'b1) && (q_x ==  1'b1) && (stall_x ==  1'b0))
            begin
                dc_ss <=  1'b0;
                state <=  3'b100;
            end
        end
         3'b100:
        begin
                state <=  3'b000;
        end
        endcase
    end
end
endmodule
module lm32_instruction_unit_medium_debug (
    clk_i,
    rst_i,
    stall_a,
    stall_f,
    stall_d,
    stall_x,
    stall_m,
    valid_f,
    valid_d,
    kill_f,
    branch_predict_taken_d,
    branch_predict_address_d,
    exception_m,
    branch_taken_m,
    branch_mispredict_taken_m,
    branch_target_m,
    iflush,
    i_dat_i,
    i_ack_i,
    i_err_i,
    i_rty_i,
    jtag_read_enable,
    jtag_write_enable,
    jtag_write_data,
    jtag_address,
    pc_f,
    pc_d,
    pc_x,
    pc_m,
    pc_w,
    icache_stall_request,
    icache_restart_request,
    icache_refill_request,
    icache_refilling,
    i_dat_o,
    i_adr_o,
    i_cyc_o,
    i_sel_o,
    i_stb_o,
    i_we_o,
    i_cti_o,
    i_lock_o,
    i_bte_o,
    jtag_read_data,
    jtag_access_complete,
    instruction_f,
    instruction_d
    );
parameter eba_reset =  32'h00000000;                   
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam eba_reset_minus_4 = eba_reset - 4;
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_f;                                          
input stall_d;                                          
input stall_x;                                          
input stall_m;                                          
input valid_f;                                          
input valid_d;                                          
input kill_f;                                           
input branch_predict_taken_d;                           
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_predict_address_d;          
input exception_m;
input branch_taken_m;                                   
input branch_mispredict_taken_m;                        
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_m;                   
input iflush;                                           
input [ (32-1):0] i_dat_i;                         
input i_ack_i;                                          
input i_err_i;                                          
input i_rty_i;                                          
input jtag_read_enable;                                 
input jtag_write_enable;                                
input [ 7:0] jtag_write_data;                 
input [ (32-1):0] jtag_address;                    
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;
output icache_stall_request;                            
wire   icache_stall_request;
output icache_restart_request;                          
wire   icache_restart_request;
output icache_refill_request;                           
wire   icache_refill_request;
output icache_refilling;                                
wire   icache_refilling;
output [ (32-1):0] i_dat_o;                        
reg    [ (32-1):0] i_dat_o;
output [ (32-1):0] i_adr_o;                        
reg    [ (32-1):0] i_adr_o;
output i_cyc_o;                                         
reg    i_cyc_o; 
output [ (4-1):0] i_sel_o;                 
reg    [ (4-1):0] i_sel_o;
output i_stb_o;                                         
reg    i_stb_o;
output i_we_o;                                          
reg    i_we_o;
output [ (3-1):0] i_cti_o;                       
reg    [ (3-1):0] i_cti_o;
output i_lock_o;                                        
reg    i_lock_o;
output [ (2-1):0] i_bte_o;                       
wire   [ (2-1):0] i_bte_o;
output [ 7:0] jtag_read_data;                 
reg    [ 7:0] jtag_read_data;
output jtag_access_complete;                            
wire   jtag_access_complete;
output [ (32-1):0] instruction_f;           
wire   [ (32-1):0] instruction_f;
output [ (32-1):0] instruction_d;           
reg    [ (32-1):0] instruction_d;
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_a;                                
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] restart_address;                     
wire icache_read_enable_f;                              
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] icache_refill_address;              
reg icache_refill_ready;                                
reg [ (32-1):0] icache_refill_data;         
wire [ (32-1):0] icache_data_f;             
wire [ (3-1):0] first_cycle_type;                
wire [ (3-1):0] next_cycle_type;                 
wire last_word;                                         
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] first_address;                      
reg jtag_access;                                        
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_icache_medium_debug #(
    .associativity          (associativity),
    .sets                   (sets),
    .bytes_per_line         (bytes_per_line),
    .base_address           (base_address),
    .limit                  (limit)
    ) icache ( 
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),      
    .stall_a                (stall_a),
    .stall_f                (stall_f),
    .branch_predict_taken_d (branch_predict_taken_d),
    .valid_d                (valid_d),
    .address_a              (pc_a),
    .address_f              (pc_f),
    .read_enable_f          (icache_read_enable_f),
    .refill_ready           (icache_refill_ready),
    .refill_data            (icache_refill_data),
    .iflush                 (iflush),
    .stall_request          (icache_stall_request),
    .restart_request        (icache_restart_request),
    .refill_request         (icache_refill_request),
    .refill_address         (icache_refill_address),
    .refilling              (icache_refilling),
    .inst                   (icache_data_f)
    );
assign icache_read_enable_f =    (valid_f ==  1'b1)
                              && (kill_f ==  1'b0)
                              ;
always @(*)
begin
      if (branch_taken_m ==  1'b1)
	if ((branch_mispredict_taken_m ==  1'b1) && (exception_m ==  1'b0))
	  pc_a = pc_x;
	else
          pc_a = branch_target_m;
      else
	if ( (valid_d ==  1'b1) && (branch_predict_taken_d ==  1'b1) )
	  pc_a = branch_predict_address_d;
	else
          if (icache_restart_request ==  1'b1)
            pc_a = restart_address;
	  else 
            pc_a = pc_f + 1'b1;
end
assign instruction_f = icache_data_f;
assign i_bte_o =  2'b00;
generate
    case (bytes_per_line)
    4:
    begin
assign first_cycle_type =  3'b111;
assign next_cycle_type =  3'b111;
assign last_word =  1'b1;
assign first_address = icache_refill_address;
    end
    8:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type =  3'b111;
assign last_word = i_adr_o[addr_offset_msb:addr_offset_lsb] == 1'b1;
assign first_address = {icache_refill_address[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:addr_offset_msb+1], {addr_offset_width{1'b0}}};
    end
    16:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type = i_adr_o[addr_offset_msb] == 1'b1 ?  3'b111 :  3'b010;
assign last_word = i_adr_o[addr_offset_msb:addr_offset_lsb] == 2'b11;
assign first_address = {icache_refill_address[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:addr_offset_msb+1], {addr_offset_width{1'b0}}};
    end
    endcase
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        pc_f <= eba_reset_minus_4[ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2];
        pc_d <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_x <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_m <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_w <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
    end
    else
    begin
        if (stall_f ==  1'b0)
            pc_f <= pc_a;
        if (stall_d ==  1'b0)
            pc_d <= pc_f;
        if (stall_x ==  1'b0)
            pc_x <= pc_d;
        if (stall_m ==  1'b0)
            pc_m <= pc_x;
        pc_w <= pc_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        restart_address <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
    else
    begin
            if (icache_refill_request ==  1'b1)
                restart_address <= icache_refill_address;
    end
end
assign jtag_access_complete = (i_cyc_o ==  1'b1) && ((i_ack_i ==  1'b1) || (i_err_i ==  1'b1)) && (jtag_access ==  1'b1);
always @(*)
begin
    case (jtag_address[1:0])
    2'b00: jtag_read_data = i_dat_i[ 31:24];
    2'b01: jtag_read_data = i_dat_i[ 23:16];
    2'b10: jtag_read_data = i_dat_i[ 15:8];
    2'b11: jtag_read_data = i_dat_i[ 7:0];
    endcase 
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        i_cyc_o <=  1'b0;
        i_stb_o <=  1'b0;
        i_adr_o <= { 32{1'b0}};
        i_cti_o <=  3'b111;
        i_lock_o <=  1'b0;
        icache_refill_data <= { 32{1'b0}};
        icache_refill_ready <=  1'b0;
        i_we_o <=  1'b0;
        i_sel_o <= 4'b1111;
        jtag_access <=  1'b0;
    end
    else
    begin   
        icache_refill_ready <=  1'b0;
        if (i_cyc_o ==  1'b1)
        begin
            if ((i_ack_i ==  1'b1) || (i_err_i ==  1'b1))
            begin
                if (jtag_access ==  1'b1)
                begin
                    i_cyc_o <=  1'b0;
                    i_stb_o <=  1'b0;       
                    i_we_o <=  1'b0;  
                    jtag_access <=  1'b0;    
                end
                else
                begin
                    if (last_word ==  1'b1)
                    begin
                        i_cyc_o <=  1'b0;
                        i_stb_o <=  1'b0;
                        i_lock_o <=  1'b0;
                    end
                    i_adr_o[addr_offset_msb:addr_offset_lsb] <= i_adr_o[addr_offset_msb:addr_offset_lsb] + 1'b1;
                    i_cti_o <= next_cycle_type;
                    icache_refill_ready <=  1'b1;
                    icache_refill_data <= i_dat_i;
                end
            end
        end
        else
        begin
            if ((icache_refill_request ==  1'b1) && (icache_refill_ready ==  1'b0))
            begin
                i_sel_o <= 4'b1111;
                i_adr_o <= {first_address, 2'b00};
                i_cyc_o <=  1'b1;
                i_stb_o <=  1'b1;                
                i_cti_o <= first_cycle_type;
            end
            else
            begin
                if ((jtag_read_enable ==  1'b1) || (jtag_write_enable ==  1'b1))
                begin
                    case (jtag_address[1:0])
                    2'b00: i_sel_o <= 4'b1000;
                    2'b01: i_sel_o <= 4'b0100;
                    2'b10: i_sel_o <= 4'b0010;
                    2'b11: i_sel_o <= 4'b0001;
                    endcase
                    i_adr_o <= jtag_address;
                    i_dat_o <= {4{jtag_write_data}};
                    i_cyc_o <=  1'b1;
                    i_stb_o <=  1'b1;
                    i_we_o <= jtag_write_enable;
                    i_cti_o <=  3'b111;
                    jtag_access <=  1'b1;
                end
            end 
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        instruction_d <= { 32{1'b0}};
    end
    else
    begin
        if (stall_d ==  1'b0)
        begin
            instruction_d <= instruction_f;
        end
    end
end  
endmodule
module lm32_jtag_medium_debug (
    clk_i,
    rst_i,
    jtag_clk, 
    jtag_update,
    jtag_reg_q,
    jtag_reg_addr_q,
    csr,
    csr_write_enable,
    csr_write_data,
    stall_x,
    jtag_read_data,
    jtag_access_complete,
    exception_q_w,
    jtx_csr_read_data,
    jrx_csr_read_data,
    jtag_csr_write_enable,
    jtag_csr_write_data,
    jtag_csr,
    jtag_read_enable,
    jtag_write_enable,
    jtag_write_data,
    jtag_address,
    jtag_break,
    jtag_reset,
    jtag_reg_d,
    jtag_reg_addr_d
    );
input clk_i;                                            
input rst_i;                                            
input jtag_clk;                                         
input jtag_update;                                      
input [ 7:0] jtag_reg_q;                      
input [2:0] jtag_reg_addr_q;                            
input [ (5-1):0] csr;                              
input csr_write_enable;                                 
input [ (32-1):0] csr_write_data;                  
input stall_x;                                          
input [ 7:0] jtag_read_data;                  
input jtag_access_complete;                             
input exception_q_w;                                    
output [ (32-1):0] jtx_csr_read_data;              
wire   [ (32-1):0] jtx_csr_read_data;
output [ (32-1):0] jrx_csr_read_data;              
wire   [ (32-1):0] jrx_csr_read_data;
output jtag_csr_write_enable;                           
reg    jtag_csr_write_enable;
output [ (32-1):0] jtag_csr_write_data;            
wire   [ (32-1):0] jtag_csr_write_data;
output [ (5-1):0] jtag_csr;                        
wire   [ (5-1):0] jtag_csr;
output jtag_read_enable;                                
reg    jtag_read_enable;
output jtag_write_enable;                               
reg    jtag_write_enable;
output [ 7:0] jtag_write_data;                
wire   [ 7:0] jtag_write_data;        
output [ (32-1):0] jtag_address;                   
wire   [ (32-1):0] jtag_address;
output jtag_break;                                      
reg    jtag_break;
output jtag_reset;                                      
reg    jtag_reset;
output [ 7:0] jtag_reg_d;
reg    [ 7:0] jtag_reg_d;
output [2:0] jtag_reg_addr_d;
wire   [2:0] jtag_reg_addr_d;
reg rx_update;                          
reg rx_update_r;                        
reg rx_update_r_r;                      
reg rx_update_r_r_r;                    
wire [ 7:0] rx_byte;   
wire [2:0] rx_addr;
reg [ 7:0] uart_tx_byte;      
reg uart_tx_valid;                      
reg [ 7:0] uart_rx_byte;      
reg uart_rx_valid;                      
reg [ 3:0] command;             
reg [ 7:0] jtag_byte_0;       
reg [ 7:0] jtag_byte_1;
reg [ 7:0] jtag_byte_2;
reg [ 7:0] jtag_byte_3;
reg [ 7:0] jtag_byte_4;
reg processing;                         
reg [ 3:0] state;       
assign jtag_csr_write_data = {jtag_byte_0, jtag_byte_1, jtag_byte_2, jtag_byte_3};
assign jtag_csr = jtag_byte_4[ (5-1):0];
assign jtag_address = {jtag_byte_0, jtag_byte_1, jtag_byte_2, jtag_byte_3};
assign jtag_write_data = jtag_byte_4;
assign jtag_reg_addr_d[1:0] = {uart_rx_valid, uart_tx_valid};         
assign jtag_reg_addr_d[2] = processing;
assign jtx_csr_read_data = {{ 32-9{1'b0}}, uart_tx_valid, 8'h00};
assign jrx_csr_read_data = {{ 32-9{1'b0}}, uart_rx_valid, uart_rx_byte};
assign rx_byte = jtag_reg_q;
assign rx_addr = jtag_reg_addr_q;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        rx_update <= 1'b0;
        rx_update_r <= 1'b0;
        rx_update_r_r <= 1'b0;
        rx_update_r_r_r <= 1'b0;
    end
    else
    begin
        rx_update <= jtag_update;
        rx_update_r <= rx_update;
        rx_update_r_r <= rx_update_r;
        rx_update_r_r_r <= rx_update_r_r;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        state <=  4'h0;
        command <= 4'b0000;
        jtag_reg_d <= 8'h00;
        processing <=  1'b0;
        jtag_csr_write_enable <=  1'b0;
        jtag_read_enable <=  1'b0;
        jtag_write_enable <=  1'b0;
        jtag_break <=  1'b0;
        jtag_reset <=  1'b0;
        uart_tx_byte <= 8'h00;
        uart_tx_valid <=  1'b0;
        uart_rx_byte <= 8'h00;
        uart_rx_valid <=  1'b0;
    end
    else
    begin
        if ((csr_write_enable ==  1'b1) && (stall_x ==  1'b0))
        begin
            case (csr)
             5'he:
            begin
                uart_tx_byte <= csr_write_data[ 7:0];
                uart_tx_valid <=  1'b1;
            end
             5'hf:
            begin
                uart_rx_valid <=  1'b0;
            end
            endcase
        end
        if (exception_q_w ==  1'b1)
        begin
            jtag_break <=  1'b0;
            jtag_reset <=  1'b0;
        end
        case (state)
         4'h0:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                command <= rx_byte[7:4];                
                case (rx_addr)
                 3'b000:
                begin
                    case (rx_byte[7:4])
                     4'b0001:
                        state <=  4'h1;
                     4'b0011:
                    begin
                        {jtag_byte_2, jtag_byte_3} <= {jtag_byte_2, jtag_byte_3} + 1'b1;
                        state <=  4'h6;
                    end
                     4'b0010:
                        state <=  4'h1;
                     4'b0100:
                    begin
                        {jtag_byte_2, jtag_byte_3} <= {jtag_byte_2, jtag_byte_3} + 1'b1;
                        state <= 5;
                    end
                     4'b0101:
                        state <=  4'h1;
                     4'b0110:
                    begin
                        uart_rx_valid <=  1'b0;    
                        uart_tx_valid <=  1'b0;         
                        jtag_break <=  1'b1;
                    end
                     4'b0111:
                    begin
                        uart_rx_valid <=  1'b0;    
                        uart_tx_valid <=  1'b0;         
                        jtag_reset <=  1'b1;
                    end
                    endcase                               
                end
                 3'b001:
                begin
                    uart_rx_byte <= rx_byte;
                    uart_rx_valid <=  1'b1;
                end                    
                 3'b010:
                begin
                    jtag_reg_d <= uart_tx_byte;
                    uart_tx_valid <=  1'b0;
                end
                default:
                    ;
                endcase                
            end
        end
         4'h1:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_0 <= rx_byte;
                state <=  4'h2;
            end
        end
         4'h2:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_1 <= rx_byte;
                state <=  4'h3;
            end
        end
         4'h3:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_2 <= rx_byte;
                state <=  4'h4;
            end
        end
         4'h4:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_3 <= rx_byte;
                if (command ==  4'b0001)
                    state <=  4'h6;
                else 
                    state <=  4'h5;
            end
        end
         4'h5:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_4 <= rx_byte;
                state <=  4'h6;
            end
        end
         4'h6:
        begin
            case (command)
             4'b0001,
             4'b0011:
            begin
                jtag_read_enable <=  1'b1;
                processing <=  1'b1;
                state <=  4'h7;
            end
             4'b0010,
             4'b0100:
            begin
                jtag_write_enable <=  1'b1;
                processing <=  1'b1;
                state <=  4'h7;
            end
             4'b0101:
            begin
                jtag_csr_write_enable <=  1'b1;
                processing <=  1'b1;
                state <=  4'h8;
            end
            endcase
        end
         4'h7:
        begin
            if (jtag_access_complete ==  1'b1)
            begin          
                jtag_read_enable <=  1'b0;
                jtag_reg_d <= jtag_read_data;
                jtag_write_enable <=  1'b0;  
                processing <=  1'b0;
                state <=  4'h0;
            end
        end    
         4'h8:
        begin
            jtag_csr_write_enable <=  1'b0;
            processing <=  1'b0;
            state <=  4'h0;
        end    
        endcase
    end
end
endmodule
module lm32_interrupt_medium_debug (
    clk_i, 
    rst_i,
    interrupt,
    stall_x,
    non_debug_exception,
    debug_exception,
    eret_q_x,
    bret_q_x,
    csr,
    csr_write_data,
    csr_write_enable,
    interrupt_exception,
    csr_read_data
    );
parameter interrupts =  32;         
input clk_i;                                    
input rst_i;                                    
input [interrupts-1:0] interrupt;               
input stall_x;                                  
input non_debug_exception;                      
input debug_exception;                          
input eret_q_x;                                 
input bret_q_x;                                 
input [ (5-1):0] csr;                      
input [ (32-1):0] csr_write_data;          
input csr_write_enable;                         
output interrupt_exception;                     
wire   interrupt_exception;
output [ (32-1):0] csr_read_data;          
reg    [ (32-1):0] csr_read_data;
wire [interrupts-1:0] asserted;                 
wire [interrupts-1:0] interrupt_n_exception;
reg ie;                                         
reg eie;                                        
reg bie;                                        
reg [interrupts-1:0] ip;                        
reg [interrupts-1:0] im;                        
assign interrupt_n_exception = ip & im;
assign interrupt_exception = (|interrupt_n_exception) & ie;
assign asserted = ip | interrupt;
generate
    if (interrupts > 1) 
    begin
always @(*)
begin
    case (csr)
     5'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    bie,
                                    eie, 
                                    ie
                                   };
     5'h2:  csr_read_data = ip;
     5'h1:  csr_read_data = im;
    default:       csr_read_data = { 32{1'bx}};
    endcase
end
    end
    else
    begin
always @(*)
begin
    case (csr)
     5'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    bie, 
                                    eie, 
                                    ie
                                   };
     5'h2:  csr_read_data = ip;
    default:       csr_read_data = { 32{1'bx}};
      endcase
end
    end
endgenerate
   reg [ 10:0] eie_delay  = 0;
generate
    if (interrupts > 1)
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie                   <=  1'b0;
        eie                  <=  1'b0;
        bie                  <=  1'b0;
        im                   <= {interrupts{1'b0}};
        ip                   <= {interrupts{1'b0}};
       eie_delay             <= 0;
    end
    else
    begin
        ip                   <= asserted;
        if (non_debug_exception ==  1'b1)
        begin
            eie              <= ie;
            ie               <=  1'b0;
        end
        else if (debug_exception ==  1'b1)
        begin
            bie              <= ie;
            ie               <=  1'b0;
        end
        else if (stall_x ==  1'b0)
        begin
           if(eie_delay[0])
             ie              <= eie;
           eie_delay         <= {1'b0, eie_delay[ 10:1]};
            if (eret_q_x ==  1'b1) begin
               eie_delay[ 10] <=  1'b1;
               eie_delay[ 10-1:0] <= 0;
            end
            else if (bret_q_x ==  1'b1)
                ie      <= bie;
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  5'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                    bie <= csr_write_data[2];
                end
                if (csr ==  5'h1)
                    im  <= csr_write_data[interrupts-1:0];
                if (csr ==  5'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
else
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie              <=  1'b0;
        eie             <=  1'b0;
        bie             <=  1'b0;
        ip              <= {interrupts{1'b0}};
       eie_delay        <= 0;
    end
    else
    begin
        ip              <= asserted;
        if (non_debug_exception ==  1'b1)
        begin
            eie         <= ie;
            ie          <=  1'b0;
        end
        else if (debug_exception ==  1'b1)
        begin
            bie         <= ie;
            ie          <=  1'b0;
        end
        else if (stall_x ==  1'b0)
          begin
             if(eie_delay[0])
               ie              <= eie;
             eie_delay         <= {1'b0, eie_delay[ 10:1]};
             if (eret_q_x ==  1'b1) begin
                eie_delay[ 10] <=  1'b1;
                eie_delay[ 10-1:0] <= 0;
             end
            else if (bret_q_x ==  1'b1)
                ie      <= bie;
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  5'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                    bie <= csr_write_data[2];
                end
                if (csr ==  5'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
endgenerate
endmodule
module lm32_top_medium_icache (
    clk_i,
    rst_i,
    interrupt,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset = 32'h00000000;
parameter sdb_address = 32'h00000000;
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_cpu_medium_icache 
	#(
		.eba_reset(eba_reset),
    .sdb_address(sdb_address)
	) cpu (
    .clk_i                 (clk_i),
    .rst_i                 (rst_i),
    .interrupt             (interrupt),
    .I_DAT_I               (I_DAT_I),
    .I_ACK_I               (I_ACK_I),
    .I_ERR_I               (I_ERR_I),
    .I_RTY_I               (I_RTY_I),
    .D_DAT_I               (D_DAT_I),
    .D_ACK_I               (D_ACK_I),
    .D_ERR_I               (D_ERR_I),
    .D_RTY_I               (D_RTY_I),
    .I_DAT_O               (I_DAT_O),
    .I_ADR_O               (I_ADR_O),
    .I_CYC_O               (I_CYC_O),
    .I_SEL_O               (I_SEL_O),
    .I_STB_O               (I_STB_O),
    .I_WE_O                (I_WE_O),
    .I_CTI_O               (I_CTI_O),
    .I_LOCK_O              (I_LOCK_O),
    .I_BTE_O               (I_BTE_O),
    .D_DAT_O               (D_DAT_O),
    .D_ADR_O               (D_ADR_O),
    .D_CYC_O               (D_CYC_O),
    .D_SEL_O               (D_SEL_O),
    .D_STB_O               (D_STB_O),
    .D_WE_O                (D_WE_O),
    .D_CTI_O               (D_CTI_O),
    .D_LOCK_O              (D_LOCK_O),
    .D_BTE_O               (D_BTE_O)
    );
endmodule
module lm32_mc_arithmetic_medium_icache (
    clk_i,
    rst_i,
    stall_d,
    kill_x,
    operand_0_d,
    operand_1_d,
    result_x,
    stall_request_x
    );
input clk_i;                                    
input rst_i;                                    
input stall_d;                                  
input kill_x;                                   
input [ (32-1):0] operand_0_d;
input [ (32-1):0] operand_1_d;
output [ (32-1):0] result_x;               
reg    [ (32-1):0] result_x;
output stall_request_x;                         
wire   stall_request_x;
reg [ (32-1):0] p;                         
reg [ (32-1):0] a;
reg [ (32-1):0] b;
reg [ 2:0] state;                 
reg [5:0] cycles;                               
assign stall_request_x = state !=  3'b000;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        cycles <= {6{1'b0}};
        p <= { 32{1'b0}};
        a <= { 32{1'b0}};
        b <= { 32{1'b0}};
        result_x <= { 32{1'b0}};
        state <=  3'b000;
    end
    else
    begin
        case (state)
         3'b000:
        begin
            if (stall_d ==  1'b0)                 
            begin          
                cycles <=  32;
                p <= 32'b0;
                a <= operand_0_d;
                b <= operand_1_d;                    
            end            
        end
        endcase
    end
end 
endmodule
module lm32_cpu_medium_icache (
    clk_i,
    rst_i,
    interrupt,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset =  32'h00000000;                           
parameter sdb_address =   32'h00000000;
parameter icache_associativity =  1;     
parameter icache_sets =  256;                       
parameter icache_bytes_per_line =  16;   
parameter icache_base_address =  32'h0;       
parameter icache_limit =  32'h7fffffff;                     
parameter dcache_associativity = 1;    
parameter dcache_sets = 512;                      
parameter dcache_bytes_per_line = 16;  
parameter dcache_base_address = 0;      
parameter dcache_limit = 0;                    
parameter watchpoints = 0;
parameter breakpoints = 0;
parameter interrupts =  32;                         
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
reg valid_a;                                    
reg valid_f;                                    
reg valid_d;                                    
reg valid_x;                                    
reg valid_m;                                    
reg valid_w;                                    
wire q_x;
wire [ (32-1):0] immediate_d;              
wire load_d;                                    
reg load_x;                                     
reg load_m;
wire load_q_x;
wire store_q_x;
wire q_m;
wire load_q_m;
wire store_q_m;
wire store_d;                                   
reg store_x;
reg store_m;
wire [ 1:0] size_d;                   
reg [ 1:0] size_x;
wire branch_d;                                  
wire branch_predict_d;                          
wire branch_predict_taken_d;                    
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_predict_address_d;   
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_d;
wire bi_unconditional;
wire bi_conditional;
reg branch_x;                                   
reg branch_predict_x;
reg branch_predict_taken_x;
reg branch_m;
reg branch_predict_m;
reg branch_predict_taken_m;
wire branch_mispredict_taken_m;                 
wire branch_flushX_m;                           
wire branch_reg_d;                              
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset_d;            
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_x;             
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_m;
wire [ 0:0] d_result_sel_0_d; 
wire [ 1:0] d_result_sel_1_d; 
wire x_result_sel_csr_d;                        
reg x_result_sel_csr_x;
wire x_result_sel_sext_d;                       
reg x_result_sel_sext_x;
wire x_result_sel_logic_d;                      
wire x_result_sel_add_d;                        
reg x_result_sel_add_x;
wire m_result_sel_compare_d;                    
reg m_result_sel_compare_x;
reg m_result_sel_compare_m;
wire m_result_sel_shift_d;                      
reg m_result_sel_shift_x;
reg m_result_sel_shift_m;
wire w_result_sel_load_d;                       
reg w_result_sel_load_x;
reg w_result_sel_load_m;
reg w_result_sel_load_w;
wire w_result_sel_mul_d;                        
reg w_result_sel_mul_x;
reg w_result_sel_mul_m;
reg w_result_sel_mul_w;
wire x_bypass_enable_d;                         
reg x_bypass_enable_x;                          
wire m_bypass_enable_d;                         
reg m_bypass_enable_x;                          
reg m_bypass_enable_m;
wire sign_extend_d;                             
reg sign_extend_x;
wire write_enable_d;                            
reg write_enable_x;
wire write_enable_q_x;
reg write_enable_m;
wire write_enable_q_m;
reg write_enable_w;
wire write_enable_q_w;
wire read_enable_0_d;                           
wire [ (5-1):0] read_idx_0_d;          
wire read_enable_1_d;                           
wire [ (5-1):0] read_idx_1_d;          
wire [ (5-1):0] write_idx_d;           
reg [ (5-1):0] write_idx_x;            
reg [ (5-1):0] write_idx_m;
reg [ (5-1):0] write_idx_w;
wire [ (4 -1):0] csr_d;                     
reg  [ (4 -1):0] csr_x;                  
wire [ (3-1):0] condition_d;         
reg [ (3-1):0] condition_x;          
wire scall_d;                                   
reg scall_x;    
wire eret_d;                                    
reg eret_x;
wire eret_q_x;
wire csr_write_enable_d;                        
reg csr_write_enable_x;
wire csr_write_enable_q_x;
reg [ (32-1):0] d_result_0;                
reg [ (32-1):0] d_result_1;                
reg [ (32-1):0] x_result;                  
reg [ (32-1):0] m_result;                  
reg [ (32-1):0] w_result;                  
reg [ (32-1):0] operand_0_x;               
reg [ (32-1):0] operand_1_x;               
reg [ (32-1):0] store_operand_x;           
reg [ (32-1):0] operand_m;                 
reg [ (32-1):0] operand_w;                 
reg [ (32-1):0] reg_data_live_0;          
reg [ (32-1):0] reg_data_live_1;  
reg use_buf;                                    
reg [ (32-1):0] reg_data_buf_0;
reg [ (32-1):0] reg_data_buf_1;
wire [ (32-1):0] reg_data_0;               
wire [ (32-1):0] reg_data_1;               
reg [ (32-1):0] bypass_data_0;             
reg [ (32-1):0] bypass_data_1;             
wire reg_write_enable_q_w;
reg interlock;                                  
wire stall_a;                                   
wire stall_f;                                   
wire stall_d;                                   
wire stall_x;                                   
wire stall_m;                                   
wire adder_op_d;                                
reg adder_op_x;                                 
reg adder_op_x_n;                               
wire [ (32-1):0] adder_result_x;           
wire adder_overflow_x;                          
wire adder_carry_n_x;                           
wire [ 3:0] logic_op_d;           
reg [ 3:0] logic_op_x;            
wire [ (32-1):0] logic_result_x;           
wire [ (32-1):0] sextb_result_x;           
wire [ (32-1):0] sexth_result_x;           
wire [ (32-1):0] sext_result_x;            
wire direction_d;                               
reg direction_x;                                        
wire [ (32-1):0] shifter_result_m;         
wire [ (32-1):0] multiplier_result_w;      
wire [ (32-1):0] interrupt_csr_read_data_x;
wire [ (32-1):0] cfg;                      
wire [ (32-1):0] cfg2;                     
reg [ (32-1):0] csr_read_data_x;           
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;                       
wire [ (32-1):0] instruction_f;     
wire [ (32-1):0] instruction_d;     
wire iflush;                                    
wire icache_stall_request;                      
wire icache_restart_request;                    
wire icache_refill_request;                     
wire icache_refilling;                          
wire [ (32-1):0] load_data_w;              
wire stall_wb_load;                             
wire raw_x_0;                                   
wire raw_x_1;                                   
wire raw_m_0;                                   
wire raw_m_1;                                   
wire raw_w_0;                                   
wire raw_w_1;                                   
wire cmp_zero;                                  
wire cmp_negative;                              
wire cmp_overflow;                              
wire cmp_carry_n;                               
reg condition_met_x;                            
reg condition_met_m;
wire branch_taken_m;                            
wire kill_f;                                    
wire kill_d;                                    
wire kill_x;                                    
wire kill_m;                                    
wire kill_w;                                    
reg [ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8] eba;                 
reg [ (3-1):0] eid_x;                      
wire exception_x;                               
reg exception_m;
reg exception_w;
wire exception_q_w;
wire interrupt_exception;                       
wire system_call_exception;                     
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_instruction_unit_medium_icache #(
    .eba_reset              (eba_reset),
    .associativity          (icache_associativity),
    .sets                   (icache_sets),
    .bytes_per_line         (icache_bytes_per_line),
    .base_address           (icache_base_address),
    .limit                  (icache_limit)
  ) instruction_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_f                (stall_f),
    .stall_d                (stall_d),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .valid_f                (valid_f),
    .valid_d                (valid_d),
    .kill_f                 (kill_f),
    .branch_predict_taken_d (branch_predict_taken_d),
    .branch_predict_address_d (branch_predict_address_d),
    .exception_m            (exception_m),
    .branch_taken_m         (branch_taken_m),
    .branch_mispredict_taken_m (branch_mispredict_taken_m),
    .branch_target_m        (branch_target_m),
    .iflush                 (iflush),
    .i_dat_i                (I_DAT_I),
    .i_ack_i                (I_ACK_I),
    .i_err_i                (I_ERR_I),
    .i_rty_i                (I_RTY_I),
    .pc_f                   (pc_f),
    .pc_d                   (pc_d),
    .pc_x                   (pc_x),
    .pc_m                   (pc_m),
    .pc_w                   (pc_w),
    .icache_stall_request   (icache_stall_request),
    .icache_restart_request (icache_restart_request),
    .icache_refill_request  (icache_refill_request),
    .icache_refilling       (icache_refilling),
    .i_dat_o                (I_DAT_O),
    .i_adr_o                (I_ADR_O),
    .i_cyc_o                (I_CYC_O),
    .i_sel_o                (I_SEL_O),
    .i_stb_o                (I_STB_O),
    .i_we_o                 (I_WE_O),
    .i_cti_o                (I_CTI_O),
    .i_lock_o               (I_LOCK_O),
    .i_bte_o                (I_BTE_O),
    .instruction_f          (instruction_f),
    .instruction_d          (instruction_d)
    );
lm32_decoder_medium_icache decoder (
    .instruction            (instruction_d),
    .d_result_sel_0         (d_result_sel_0_d),
    .d_result_sel_1         (d_result_sel_1_d),
    .x_result_sel_csr       (x_result_sel_csr_d),
    .x_result_sel_sext      (x_result_sel_sext_d),
    .x_result_sel_logic     (x_result_sel_logic_d),
    .x_result_sel_add       (x_result_sel_add_d),
    .m_result_sel_compare   (m_result_sel_compare_d),
    .m_result_sel_shift     (m_result_sel_shift_d),  
    .w_result_sel_load      (w_result_sel_load_d),
    .w_result_sel_mul       (w_result_sel_mul_d),
    .x_bypass_enable        (x_bypass_enable_d),
    .m_bypass_enable        (m_bypass_enable_d),
    .read_enable_0          (read_enable_0_d),
    .read_idx_0             (read_idx_0_d),
    .read_enable_1          (read_enable_1_d),
    .read_idx_1             (read_idx_1_d),
    .write_enable           (write_enable_d),
    .write_idx              (write_idx_d),
    .immediate              (immediate_d),
    .branch_offset          (branch_offset_d),
    .load                   (load_d),
    .store                  (store_d),
    .size                   (size_d),
    .sign_extend            (sign_extend_d),
    .adder_op               (adder_op_d),
    .logic_op               (logic_op_d),
    .direction              (direction_d),
    .branch                 (branch_d),
    .bi_unconditional       (bi_unconditional),
    .bi_conditional         (bi_conditional),
    .branch_reg             (branch_reg_d),
    .condition              (condition_d),
    .scall                  (scall_d),
    .eret                   (eret_d),
    .csr_write_enable       (csr_write_enable_d)
    ); 
lm32_load_store_unit_medium_icache #(
    .associativity          (dcache_associativity),
    .sets                   (dcache_sets),
    .bytes_per_line         (dcache_bytes_per_line),
    .base_address           (dcache_base_address),
    .limit                  (dcache_limit)
  ) load_store_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .kill_x                 (kill_x),
    .kill_m                 (kill_m),
    .exception_m            (exception_m),
    .store_operand_x        (store_operand_x),
    .load_store_address_x   (adder_result_x),
    .load_store_address_m   (operand_m),
    .load_store_address_w   (operand_w[1:0]),
    .load_x                 (load_x),
    .store_x                (store_x),
    .load_q_x               (load_q_x),
    .store_q_x              (store_q_x),
    .load_q_m               (load_q_m),
    .store_q_m              (store_q_m),
    .sign_extend_x          (sign_extend_x),
    .size_x                 (size_x),
    .d_dat_i                (D_DAT_I),
    .d_ack_i                (D_ACK_I),
    .d_err_i                (D_ERR_I),
    .d_rty_i                (D_RTY_I),
    .load_data_w            (load_data_w),
    .stall_wb_load          (stall_wb_load),
    .d_dat_o                (D_DAT_O),
    .d_adr_o                (D_ADR_O),
    .d_cyc_o                (D_CYC_O),
    .d_sel_o                (D_SEL_O),
    .d_stb_o                (D_STB_O),
    .d_we_o                 (D_WE_O),
    .d_cti_o                (D_CTI_O),
    .d_lock_o               (D_LOCK_O),
    .d_bte_o                (D_BTE_O)
    );      
lm32_adder adder (
    .adder_op_x             (adder_op_x),
    .adder_op_x_n           (adder_op_x_n),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .adder_result_x         (adder_result_x),
    .adder_carry_n_x        (adder_carry_n_x),
    .adder_overflow_x       (adder_overflow_x)
    );
lm32_logic_op logic_op (
    .logic_op_x             (logic_op_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .logic_result_x         (logic_result_x)
    );
lm32_shifter shifter (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .direction_x            (direction_x),
    .sign_extend_x          (sign_extend_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .shifter_result_m       (shifter_result_m)
    );
lm32_multiplier multiplier (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .operand_0              (d_result_0),
    .operand_1              (d_result_1),
    .result                 (multiplier_result_w)    
    );
lm32_interrupt_medium_icache interrupt_unit (
    .clk_i                  (clk_i), 
    .rst_i                  (rst_i),
    .interrupt              (interrupt),
    .stall_x                (stall_x),
    .exception              (exception_q_w), 
    .eret_q_x               (eret_q_x),
    .csr                    (csr_x),
    .csr_write_data         (operand_1_x),
    .csr_write_enable       (csr_write_enable_q_x),
    .interrupt_exception    (interrupt_exception),
    .csr_read_data          (interrupt_csr_read_data_x)
    );
   wire [31:0] regfile_data_0, regfile_data_1;
   reg [31:0]  w_result_d;
   reg 	       regfile_raw_0, regfile_raw_0_nxt;
   reg 	       regfile_raw_1, regfile_raw_1_nxt;
   always @(reg_write_enable_q_w or write_idx_w or instruction_f)
     begin
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[25:21]))
	  regfile_raw_0_nxt = 1'b1;
	else
	  regfile_raw_0_nxt = 1'b0;
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[20:16]))
	  regfile_raw_1_nxt = 1'b1;
	else
	  regfile_raw_1_nxt = 1'b0;
     end
   always @(regfile_raw_0 or w_result_d or regfile_data_0)
     if (regfile_raw_0)
       reg_data_live_0 = w_result_d;
     else
       reg_data_live_0 = regfile_data_0;
   always @(regfile_raw_1 or w_result_d or regfile_data_1)
     if (regfile_raw_1)
       reg_data_live_1 = w_result_d;
     else
       reg_data_live_1 = regfile_data_1;
   always @(posedge clk_i  )
     if (rst_i ==  1'b1)
       begin
	  regfile_raw_0 <= 1'b0;
	  regfile_raw_1 <= 1'b0;
	  w_result_d <= 32'b0;
       end
     else
       begin
	  regfile_raw_0 <= regfile_raw_0_nxt;
	  regfile_raw_1 <= regfile_raw_1_nxt;
	  w_result_d <= w_result;
       end
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_0
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[25:21]),
      .rdata_o	(regfile_data_0)
      );
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_1
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[20:16]),
      .rdata_o	(regfile_data_1)
      );
assign reg_data_0 = use_buf ? reg_data_buf_0 : reg_data_live_0;
assign reg_data_1 = use_buf ? reg_data_buf_1 : reg_data_live_1;
assign raw_x_0 = (write_idx_x == read_idx_0_d) && (write_enable_q_x ==  1'b1);
assign raw_m_0 = (write_idx_m == read_idx_0_d) && (write_enable_q_m ==  1'b1);
assign raw_w_0 = (write_idx_w == read_idx_0_d) && (write_enable_q_w ==  1'b1);
assign raw_x_1 = (write_idx_x == read_idx_1_d) && (write_enable_q_x ==  1'b1);
assign raw_m_1 = (write_idx_m == read_idx_1_d) && (write_enable_q_m ==  1'b1);
assign raw_w_1 = (write_idx_w == read_idx_1_d) && (write_enable_q_w ==  1'b1);
always @(*)
begin
    if (   (   (x_bypass_enable_x ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_x_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_x_1 ==  1'b1))
               )
           )
        || (   (m_bypass_enable_m ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_m_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_m_1 ==  1'b1))
               )
           )
       )
        interlock =  1'b1;
    else
        interlock =  1'b0;
end
always @(*)
begin
    if (raw_x_0 ==  1'b1)        
        bypass_data_0 = x_result;
    else if (raw_m_0 ==  1'b1)
        bypass_data_0 = m_result;
    else if (raw_w_0 ==  1'b1)
        bypass_data_0 = w_result;
    else
        bypass_data_0 = reg_data_0;
end
always @(*)
begin
    if (raw_x_1 ==  1'b1)
        bypass_data_1 = x_result;
    else if (raw_m_1 ==  1'b1)
        bypass_data_1 = m_result;
    else if (raw_w_1 ==  1'b1)
        bypass_data_1 = w_result;
    else
        bypass_data_1 = reg_data_1;
end
   assign branch_predict_d = bi_unconditional | bi_conditional;
   assign branch_predict_taken_d = bi_unconditional ? 1'b1 : (bi_conditional ? instruction_d[15] : 1'b0);
   assign branch_target_d = pc_d + branch_offset_d;
   assign branch_predict_address_d = branch_predict_taken_d ? branch_target_d : pc_f;
always @(*)
begin
    d_result_0 = d_result_sel_0_d[0] ? {pc_f, 2'b00} : bypass_data_0; 
    case (d_result_sel_1_d)
     2'b00:      d_result_1 = { 32{1'b0}};
     2'b01:     d_result_1 = bypass_data_1;
     2'b10: d_result_1 = immediate_d;
    default:                        d_result_1 = { 32{1'bx}};
    endcase
end
assign sextb_result_x = {{24{operand_0_x[7]}}, operand_0_x[7:0]};
assign sexth_result_x = {{16{operand_0_x[15]}}, operand_0_x[15:0]};
assign sext_result_x = size_x ==  2'b00 ? sextb_result_x : sexth_result_x;
assign cmp_zero = operand_0_x == operand_1_x;
assign cmp_negative = adder_result_x[ 32-1];
assign cmp_overflow = adder_overflow_x;
assign cmp_carry_n = adder_carry_n_x;
always @(*)
begin
    case (condition_x)
     3'b000:   condition_met_x =  1'b1;
     3'b110:   condition_met_x =  1'b1;
     3'b001:    condition_met_x = cmp_zero;
     3'b111:   condition_met_x = !cmp_zero;
     3'b010:    condition_met_x = !cmp_zero && (cmp_negative == cmp_overflow);
     3'b101:   condition_met_x = cmp_carry_n && !cmp_zero;
     3'b011:   condition_met_x = cmp_negative == cmp_overflow;
     3'b100:  condition_met_x = cmp_carry_n;
    default:              condition_met_x = 1'bx;
    endcase 
end
always @(*)
begin
    x_result =   x_result_sel_add_x ? adder_result_x 
               : x_result_sel_csr_x ? csr_read_data_x
               : x_result_sel_sext_x ? sext_result_x
               : logic_result_x;
end
always @(*)
begin
    m_result =   m_result_sel_compare_m ? {{ 32-1{1'b0}}, condition_met_m}
               : m_result_sel_shift_m ? shifter_result_m
               : operand_m; 
end
always @(*)
begin
    w_result =    w_result_sel_load_w ? load_data_w
                : w_result_sel_mul_w ? multiplier_result_w
                : operand_w;
end
assign branch_taken_m =      (stall_m ==  1'b0) 
                          && (   (   (branch_m ==  1'b1) 
                                  && (valid_m ==  1'b1)
                                  && (   (   (condition_met_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b0)
					 )
				      || (   (condition_met_m ==  1'b0)
					  && (branch_predict_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b1)
					 )
				     )
                                 ) 
                              || (exception_m ==  1'b1)
                             );
assign branch_mispredict_taken_m =    (condition_met_m ==  1'b0)
                                   && (branch_predict_m ==  1'b1)
	   			   && (branch_predict_taken_m ==  1'b1);
assign branch_flushX_m =    (stall_m ==  1'b0)
                         && (   (   (branch_m ==  1'b1) 
                                 && (valid_m ==  1'b1)
			         && (   (condition_met_m ==  1'b1)
				     || (   (condition_met_m ==  1'b0)
					 && (branch_predict_m ==  1'b1)
					 && (branch_predict_taken_m ==  1'b1)
					)
				    )
			        )
			     || (exception_m ==  1'b1)
			    );
assign kill_f =    (   (valid_d ==  1'b1)
                    && (branch_predict_taken_d ==  1'b1)
		   )
                || (branch_taken_m ==  1'b1) 
                || (icache_refill_request ==  1'b1) 
                ;
assign kill_d =    (branch_taken_m ==  1'b1) 
                || (icache_refill_request ==  1'b1)     
                ;
assign kill_x =    (branch_flushX_m ==  1'b1) 
                ;
assign kill_m =     1'b0
                ;                
assign kill_w =     1'b0
                ;
assign system_call_exception = (   (scall_x ==  1'b1)
			       );
assign exception_x =           (system_call_exception ==  1'b1)
                            || (   (interrupt_exception ==  1'b1)
                               )
                            ;
always @(*)
begin
         if (   (interrupt_exception ==  1'b1)
            )
        eid_x =  3'h6;
    else
        eid_x =  3'h7;
end
assign stall_a = (stall_f ==  1'b1);
assign stall_f = (stall_d ==  1'b1);
assign stall_d =   (stall_x ==  1'b1) 
                || (   (interlock ==  1'b1)
                    && (kill_d ==  1'b0)
                   ) 
		|| (   (   (eret_d ==  1'b1)
			|| (scall_d ==  1'b1)
		       )
		    && (   (load_q_x ==  1'b1)
			|| (load_q_m ==  1'b1)
			|| (store_q_x ==  1'b1)
			|| (store_q_m ==  1'b1)
			|| (D_CYC_O ==  1'b1)
		       )
                    && (kill_d ==  1'b0)
		   )
                || (   (csr_write_enable_d ==  1'b1)
                    && (load_q_x ==  1'b1)
                   )                      
                ;
assign stall_x =    (stall_m ==  1'b1)
                 ;
assign stall_m =    (stall_wb_load ==  1'b1)
                 || (   (D_CYC_O ==  1'b1)
                     && (   (store_m ==  1'b1)
		         || ((store_x ==  1'b1) && (interrupt_exception ==  1'b1))
                         || (load_m ==  1'b1)
                         || (load_x ==  1'b1)
                        ) 
                    ) 
                 || (icache_stall_request ==  1'b1)     
                 || ((I_CYC_O ==  1'b1) && ((branch_m ==  1'b1) || (exception_m ==  1'b1))) 
                 ;      
assign q_x = (valid_x ==  1'b1) && (kill_x ==  1'b0);
assign csr_write_enable_q_x = (csr_write_enable_x ==  1'b1) && (q_x ==  1'b1);
assign eret_q_x = (eret_x ==  1'b1) && (q_x ==  1'b1);
assign load_q_x = (load_x ==  1'b1) 
               && (q_x ==  1'b1)
                  ;
assign store_q_x = (store_x ==  1'b1) 
               && (q_x ==  1'b1)
                  ;
assign q_m = (valid_m ==  1'b1) && (kill_m ==  1'b0) && (exception_m ==  1'b0);
assign load_q_m = (load_m ==  1'b1) && (q_m ==  1'b1);
assign store_q_m = (store_m ==  1'b1) && (q_m ==  1'b1);
assign exception_q_w = ((exception_w ==  1'b1) && (valid_w ==  1'b1));        
assign write_enable_q_x = (write_enable_x ==  1'b1) && (valid_x ==  1'b1) && (branch_flushX_m ==  1'b0);
assign write_enable_q_m = (write_enable_m ==  1'b1) && (valid_m ==  1'b1);
assign write_enable_q_w = (write_enable_w ==  1'b1) && (valid_w ==  1'b1);
assign reg_write_enable_q_w = (write_enable_w ==  1'b1) && (kill_w ==  1'b0) && (valid_w ==  1'b1);
assign cfg = {
               6'h02,
              watchpoints[3:0],
              breakpoints[3:0],
              interrupts[5:0],
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b1,
               1'b0,
               1'b0,
               1'b0,
               1'b1,
               1'b1,
               1'b0,
               1'b1
              };
assign cfg2 = {
		     30'b0,
		      1'b0,
		      1'b0
		     };
assign iflush = (   (csr_write_enable_d ==  1'b1) 
                 && (csr_d ==  4 'h3)
                 && (stall_d ==  1'b0)
                 && (kill_d ==  1'b0)
                 && (valid_d ==  1'b1))
		 ;
assign csr_d = read_idx_0_d[ (4 -1):0];
always @(*)
begin
    case (csr_x)
     4 'h0,
     4 'h1,
     4 'h2:   csr_read_data_x = interrupt_csr_read_data_x;  
     4 'h6:  csr_read_data_x = cfg;
     4 'h7:  csr_read_data_x = {eba, 8'h00};
     4 'ha: csr_read_data_x = cfg2;
     4 'hb:  csr_read_data_x = sdb_address;
    default:        csr_read_data_x = { 32{1'bx}};
    endcase
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        eba <= eba_reset[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    else
    begin
        if ((csr_write_enable_q_x ==  1'b1) && (csr_x ==  4 'h7) && (stall_x ==  1'b0))
            eba <= operand_1_x[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    end
end
always @(*)
begin
    if (icache_refill_request ==  1'b1) 
        valid_a =  1'b0;
    else if (icache_restart_request ==  1'b1) 
        valid_a =  1'b1;
    else 
        valid_a = !icache_refilling;
end 
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        valid_f <=  1'b0;
        valid_d <=  1'b0;
        valid_x <=  1'b0;
        valid_m <=  1'b0;
        valid_w <=  1'b0;
    end
    else
    begin    
        if ((kill_f ==  1'b1) || (stall_a ==  1'b0))
            valid_f <= valid_a;    
        else if (stall_f ==  1'b0)
            valid_f <=  1'b0;            
        if (kill_d ==  1'b1)
            valid_d <=  1'b0;
        else if (stall_f ==  1'b0)
            valid_d <= valid_f & !kill_f;
        else if (stall_d ==  1'b0)
            valid_d <=  1'b0;
        if (stall_d ==  1'b0)
            valid_x <= valid_d & !kill_d;
        else if (kill_x ==  1'b1)
            valid_x <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_x <=  1'b0;
        if (kill_m ==  1'b1)
            valid_m <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_m <= valid_x & !kill_x;
        else if (stall_m ==  1'b0)
            valid_m <=  1'b0;
        if (stall_m ==  1'b0)
            valid_w <= valid_m & !kill_m;
        else 
            valid_w <=  1'b0;        
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        operand_0_x <= { 32{1'b0}};
        operand_1_x <= { 32{1'b0}};
        store_operand_x <= { 32{1'b0}};
        branch_target_x <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};        
        x_result_sel_csr_x <=  1'b0;
        x_result_sel_sext_x <=  1'b0;
        x_result_sel_add_x <=  1'b0;
        m_result_sel_compare_x <=  1'b0;
        m_result_sel_shift_x <=  1'b0;
        w_result_sel_load_x <=  1'b0;
        w_result_sel_mul_x <=  1'b0;
        x_bypass_enable_x <=  1'b0;
        m_bypass_enable_x <=  1'b0;
        write_enable_x <=  1'b0;
        write_idx_x <= { 5{1'b0}};
        csr_x <= { 4 {1'b0}};
        load_x <=  1'b0;
        store_x <=  1'b0;
        size_x <= { 2{1'b0}};
        sign_extend_x <=  1'b0;
        adder_op_x <=  1'b0;
        adder_op_x_n <=  1'b0;
        logic_op_x <= 4'h0;
        direction_x <=  1'b0;
        branch_x <=  1'b0;
        branch_predict_x <=  1'b0;
        branch_predict_taken_x <=  1'b0;
        condition_x <=  3'b000;
        scall_x <=  1'b0;
        eret_x <=  1'b0;
        csr_write_enable_x <=  1'b0;
        operand_m <= { 32{1'b0}};
        branch_target_m <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        m_result_sel_compare_m <=  1'b0;
        m_result_sel_shift_m <=  1'b0;
        w_result_sel_load_m <=  1'b0;
        w_result_sel_mul_m <=  1'b0;
        m_bypass_enable_m <=  1'b0;
        branch_m <=  1'b0;
        branch_predict_m <=  1'b0;
	branch_predict_taken_m <=  1'b0;
        exception_m <=  1'b0;
        load_m <=  1'b0;
        store_m <=  1'b0;
        write_enable_m <=  1'b0;            
        write_idx_m <= { 5{1'b0}};
        condition_met_m <=  1'b0;
        operand_w <= { 32{1'b0}};        
        w_result_sel_load_w <=  1'b0;
        w_result_sel_mul_w <=  1'b0;
        write_idx_w <= { 5{1'b0}};        
        write_enable_w <=  1'b0;
        exception_w <=  1'b0;
    end
    else
    begin
        if (stall_x ==  1'b0)
        begin
            operand_0_x <= d_result_0;
            operand_1_x <= d_result_1;
            store_operand_x <= bypass_data_1;
            branch_target_x <= branch_reg_d ==  1'b1 ? bypass_data_0[ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] : branch_target_d;            
            x_result_sel_csr_x <= x_result_sel_csr_d;
            x_result_sel_sext_x <= x_result_sel_sext_d;
            x_result_sel_add_x <= x_result_sel_add_d;
            m_result_sel_compare_x <= m_result_sel_compare_d;
            m_result_sel_shift_x <= m_result_sel_shift_d;
            w_result_sel_load_x <= w_result_sel_load_d;
            w_result_sel_mul_x <= w_result_sel_mul_d;
            x_bypass_enable_x <= x_bypass_enable_d;
            m_bypass_enable_x <= m_bypass_enable_d;
            load_x <= load_d;
            store_x <= store_d;
            branch_x <= branch_d;
	    branch_predict_x <= branch_predict_d;
	    branch_predict_taken_x <= branch_predict_taken_d;
	    write_idx_x <= write_idx_d;
            csr_x <= csr_d;
            size_x <= size_d;
            sign_extend_x <= sign_extend_d;
            adder_op_x <= adder_op_d;
            adder_op_x_n <= ~adder_op_d;
            logic_op_x <= logic_op_d;
            direction_x <= direction_d;
            condition_x <= condition_d;
            csr_write_enable_x <= csr_write_enable_d;
            scall_x <= scall_d;
            eret_x <= eret_d;
            write_enable_x <= write_enable_d;
        end
        if (stall_m ==  1'b0)
        begin
            operand_m <= x_result;
            m_result_sel_compare_m <= m_result_sel_compare_x;
            m_result_sel_shift_m <= m_result_sel_shift_x;
            if (exception_x ==  1'b1)
            begin
                w_result_sel_load_m <=  1'b0;
                w_result_sel_mul_m <=  1'b0;
            end
            else
            begin
                w_result_sel_load_m <= w_result_sel_load_x;
                w_result_sel_mul_m <= w_result_sel_mul_x;
            end
            m_bypass_enable_m <= m_bypass_enable_x;
            load_m <= load_x;
            store_m <= store_x;
            branch_m <= branch_x;
	    branch_predict_m <= branch_predict_x;
	    branch_predict_taken_m <= branch_predict_taken_x;
            if (exception_x ==  1'b1)
                write_idx_m <=  5'd30;
            else 
                write_idx_m <= write_idx_x;
            condition_met_m <= condition_met_x;
            branch_target_m <= exception_x ==  1'b1 ? {eba, eid_x, {3{1'b0}}} : branch_target_x;
            write_enable_m <= exception_x ==  1'b1 ?  1'b1 : write_enable_x;            
        end
        if (stall_m ==  1'b0)
        begin
            if ((exception_x ==  1'b1) && (q_x ==  1'b1) && (stall_x ==  1'b0))
                exception_m <=  1'b1;
            else 
                exception_m <=  1'b0;
	end
        operand_w <= exception_m ==  1'b1 ? {pc_m, 2'b00} : m_result;
        w_result_sel_load_w <= w_result_sel_load_m;
        w_result_sel_mul_w <= w_result_sel_mul_m;
        write_idx_w <= write_idx_m;
        write_enable_w <= write_enable_m;
        exception_w <= exception_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        use_buf <=  1'b0;
        reg_data_buf_0 <= { 32{1'b0}};
        reg_data_buf_1 <= { 32{1'b0}};
    end
    else
    begin
        if (stall_d ==  1'b0)
            use_buf <=  1'b0;
        else if (use_buf ==  1'b0)
        begin        
            reg_data_buf_0 <= reg_data_live_0;
            reg_data_buf_1 <= reg_data_live_1;
            use_buf <=  1'b1;
        end        
        if (reg_write_enable_q_w ==  1'b1)
        begin
            if (write_idx_w == read_idx_0_d)
                reg_data_buf_0 <= w_result;
            if (write_idx_w == read_idx_1_d)
                reg_data_buf_1 <= w_result;
        end
    end
end
initial
begin
end
endmodule 
module lm32_load_store_unit_medium_icache (
    clk_i,
    rst_i,
    stall_a,
    stall_x,
    stall_m,
    kill_x,
    kill_m,
    exception_m,
    store_operand_x,
    load_store_address_x,
    load_store_address_m,
    load_store_address_w,
    load_x,
    store_x,
    load_q_x,
    store_q_x,
    load_q_m,
    store_q_m,
    sign_extend_x,
    size_x,
    d_dat_i,
    d_ack_i,
    d_err_i,
    d_rty_i,
    load_data_w,
    stall_wb_load,
    d_dat_o,
    d_adr_o,
    d_cyc_o,
    d_sel_o,
    d_stb_o,
    d_we_o,
    d_cti_o,
    d_lock_o,
    d_bte_o
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_x;                                          
input stall_m;                                          
input kill_x;                                           
input kill_m;                                           
input exception_m;                                      
input [ (32-1):0] store_operand_x;                 
input [ (32-1):0] load_store_address_x;            
input [ (32-1):0] load_store_address_m;            
input [1:0] load_store_address_w;                       
input load_x;                                           
input store_x;                                          
input load_q_x;                                         
input store_q_x;                                        
input load_q_m;                                         
input store_q_m;                                        
input sign_extend_x;                                    
input [ 1:0] size_x;                          
input [ (32-1):0] d_dat_i;                         
input d_ack_i;                                          
input d_err_i;                                          
input d_rty_i;                                          
output [ (32-1):0] load_data_w;                    
reg    [ (32-1):0] load_data_w;
output stall_wb_load;                                   
reg    stall_wb_load;
output [ (32-1):0] d_dat_o;                        
reg    [ (32-1):0] d_dat_o;
output [ (32-1):0] d_adr_o;                        
reg    [ (32-1):0] d_adr_o;
output d_cyc_o;                                         
reg    d_cyc_o;
output [ (4-1):0] d_sel_o;                 
reg    [ (4-1):0] d_sel_o;
output d_stb_o;                                         
reg    d_stb_o; 
output d_we_o;                                          
reg    d_we_o;
output [ (3-1):0] d_cti_o;                       
reg    [ (3-1):0] d_cti_o;
output d_lock_o;                                        
reg    d_lock_o;
output [ (2-1):0] d_bte_o;                       
wire   [ (2-1):0] d_bte_o;
reg [ 1:0] size_m;
reg [ 1:0] size_w;
reg sign_extend_m;
reg sign_extend_w;
reg [ (32-1):0] store_data_x;       
reg [ (32-1):0] store_data_m;       
reg [ (4-1):0] byte_enable_x;
reg [ (4-1):0] byte_enable_m;
wire [ (32-1):0] data_m;
reg [ (32-1):0] data_w;
wire wb_select_x;                                       
reg wb_select_m;
reg [ (32-1):0] wb_data_m;                         
reg wb_load_complete;                                   
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
   assign wb_select_x =     1'b1
                     ;
always @(*)
begin
    case (size_x)
     2'b00:  store_data_x = {4{store_operand_x[7:0]}};
     2'b11: store_data_x = {2{store_operand_x[15:0]}};
     2'b10:  store_data_x = store_operand_x;    
    default:          store_data_x = { 32{1'bx}};
    endcase
end
always @(*)
begin
    casez ({size_x, load_store_address_x[1:0]})
    { 2'b00, 2'b11}:  byte_enable_x = 4'b0001;
    { 2'b00, 2'b10}:  byte_enable_x = 4'b0010;
    { 2'b00, 2'b01}:  byte_enable_x = 4'b0100;
    { 2'b00, 2'b00}:  byte_enable_x = 4'b1000;
    { 2'b11, 2'b1?}: byte_enable_x = 4'b0011;
    { 2'b11, 2'b0?}: byte_enable_x = 4'b1100;
    { 2'b10, 2'b??}:  byte_enable_x = 4'b1111;
    default:                   byte_enable_x = 4'bxxxx;
    endcase
end
   assign data_m = wb_data_m;
always @(*)
begin
    casez ({size_w, load_store_address_w[1:0]})
    { 2'b00, 2'b11}:  load_data_w = {{24{sign_extend_w & data_w[7]}}, data_w[7:0]};
    { 2'b00, 2'b10}:  load_data_w = {{24{sign_extend_w & data_w[15]}}, data_w[15:8]};
    { 2'b00, 2'b01}:  load_data_w = {{24{sign_extend_w & data_w[23]}}, data_w[23:16]};
    { 2'b00, 2'b00}:  load_data_w = {{24{sign_extend_w & data_w[31]}}, data_w[31:24]};
    { 2'b11, 2'b1?}: load_data_w = {{16{sign_extend_w & data_w[15]}}, data_w[15:0]};
    { 2'b11, 2'b0?}: load_data_w = {{16{sign_extend_w & data_w[31]}}, data_w[31:16]};
    { 2'b10, 2'b??}:  load_data_w = data_w;
    default:                   load_data_w = { 32{1'bx}};
    endcase
end
assign d_bte_o =  2'b00;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        d_cyc_o <=  1'b0;
        d_stb_o <=  1'b0;
        d_dat_o <= { 32{1'b0}};
        d_adr_o <= { 32{1'b0}};
        d_sel_o <= { 4{ 1'b0}};
        d_we_o <=  1'b0;
        d_cti_o <=  3'b111;
        d_lock_o <=  1'b0;
        wb_data_m <= { 32{1'b0}};
        wb_load_complete <=  1'b0;
        stall_wb_load <=  1'b0;
    end
    else
    begin
        if (d_cyc_o ==  1'b1)
        begin
            if ((d_ack_i ==  1'b1) || (d_err_i ==  1'b1))
            begin
                begin
                    d_cyc_o <=  1'b0;
                    d_stb_o <=  1'b0;
                    d_lock_o <=  1'b0;
                end
                wb_data_m <= d_dat_i;
                wb_load_complete <= !d_we_o;
            end
            if (d_err_i ==  1'b1)
                $display ("Data bus error. Address: %x", d_adr_o);
        end
        else
        begin
                 if (   (store_q_m ==  1'b1)
                     && (stall_m ==  1'b0)
                    )
            begin
                d_dat_o <= store_data_m;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b1;
                d_cti_o <=  3'b111;
            end        
            else if (   (load_q_m ==  1'b1) 
                     && (wb_select_m ==  1'b1) 
                     && (wb_load_complete ==  1'b0)
                    )
            begin
                stall_wb_load <=  1'b0;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b0;
                d_cti_o <=  3'b111;
            end
        end
        if (stall_m ==  1'b0)
            wb_load_complete <=  1'b0;
        if ((load_q_x ==  1'b1) && (wb_select_x ==  1'b1) && (stall_x ==  1'b0))
            stall_wb_load <=  1'b1;
        if ((kill_m ==  1'b1) || (exception_m ==  1'b1))
            stall_wb_load <=  1'b0;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        sign_extend_m <=  1'b0;
        size_m <= 2'b00;
        byte_enable_m <=  1'b0;
        store_data_m <= { 32{1'b0}};
        wb_select_m <=  1'b0;        
    end
    else
    begin
        if (stall_m ==  1'b0)
        begin
            sign_extend_m <= sign_extend_x;
            size_m <= size_x;
            byte_enable_m <= byte_enable_x;    
            store_data_m <= store_data_x;
            wb_select_m <= wb_select_x;
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        size_w <= 2'b00;
        data_w <= { 32{1'b0}};
        sign_extend_w <=  1'b0;
    end
    else
    begin
        size_w <= size_m;
        data_w <= data_m;
        sign_extend_w <= sign_extend_m;
    end
end
always @(posedge clk_i)
begin
    if (((load_q_m ==  1'b1) || (store_q_m ==  1'b1)) && (stall_m ==  1'b0)) 
    begin
        if ((size_m ===  2'b11) && (load_store_address_m[0] !== 1'b0))
            $display ("Warning: Non-aligned halfword access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
        if ((size_m ===  2'b10) && (load_store_address_m[1:0] !== 2'b00))
            $display ("Warning: Non-aligned word access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
    end
end
endmodule
module lm32_decoder_medium_icache (
    instruction,
    d_result_sel_0,
    d_result_sel_1,        
    x_result_sel_csr,
    x_result_sel_sext,
    x_result_sel_logic,
    x_result_sel_add,
    m_result_sel_compare,
    m_result_sel_shift,  
    w_result_sel_load,
    w_result_sel_mul,
    x_bypass_enable,
    m_bypass_enable,
    read_enable_0,
    read_idx_0,
    read_enable_1,
    read_idx_1,
    write_enable,
    write_idx,
    immediate,
    branch_offset,
    load,
    store,
    size,
    sign_extend,
    adder_op,
    logic_op,
    direction,
    branch,
    branch_reg,
    condition,
    bi_conditional,
    bi_unconditional,
    scall,
    eret,
    csr_write_enable
    );
input [ (32-1):0] instruction;       
output [ 0:0] d_result_sel_0;
reg    [ 0:0] d_result_sel_0;
output [ 1:0] d_result_sel_1;
reg    [ 1:0] d_result_sel_1;
output x_result_sel_csr;
reg    x_result_sel_csr;
output x_result_sel_sext;
reg    x_result_sel_sext;
output x_result_sel_logic;
reg    x_result_sel_logic;
output x_result_sel_add;
reg    x_result_sel_add;
output m_result_sel_compare;
reg    m_result_sel_compare;
output m_result_sel_shift;
reg    m_result_sel_shift;
output w_result_sel_load;
reg    w_result_sel_load;
output w_result_sel_mul;
reg    w_result_sel_mul;
output x_bypass_enable;
wire   x_bypass_enable;
output m_bypass_enable;
wire   m_bypass_enable;
output read_enable_0;
wire   read_enable_0;
output [ (5-1):0] read_idx_0;
wire   [ (5-1):0] read_idx_0;
output read_enable_1;
wire   read_enable_1;
output [ (5-1):0] read_idx_1;
wire   [ (5-1):0] read_idx_1;
output write_enable;
wire   write_enable;
output [ (5-1):0] write_idx;
wire   [ (5-1):0] write_idx;
output [ (32-1):0] immediate;
wire   [ (32-1):0] immediate;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset;
wire   [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset;
output load;
wire   load;
output store;
wire   store;
output [ 1:0] size;
wire   [ 1:0] size;
output sign_extend;
wire   sign_extend;
output adder_op;
wire   adder_op;
output [ 3:0] logic_op;
wire   [ 3:0] logic_op;
output direction;
wire   direction;
output branch;
wire   branch;
output branch_reg;
wire   branch_reg;
output [ (3-1):0] condition;
wire   [ (3-1):0] condition;
output bi_conditional;
wire bi_conditional;
output bi_unconditional;
wire bi_unconditional;
output scall;
wire   scall;
output eret;
wire   eret;
output csr_write_enable;
wire   csr_write_enable;
wire [ (32-1):0] extended_immediate;       
wire [ (32-1):0] high_immediate;           
wire [ (32-1):0] call_immediate;           
wire [ (32-1):0] branch_immediate;         
wire sign_extend_immediate;                     
wire select_high_immediate;                     
wire select_call_immediate;                     
wire op_add;
wire op_and;
wire op_andhi;
wire op_b;
wire op_bi;
wire op_be;
wire op_bg;
wire op_bge;
wire op_bgeu;
wire op_bgu;
wire op_bne;
wire op_call;
wire op_calli;
wire op_cmpe;
wire op_cmpg;
wire op_cmpge;
wire op_cmpgeu;
wire op_cmpgu;
wire op_cmpne;
wire op_lb;
wire op_lbu;
wire op_lh;
wire op_lhu;
wire op_lw;
wire op_mul;
wire op_nor;
wire op_or;
wire op_orhi;
wire op_raise;
wire op_rcsr;
wire op_sb;
wire op_sextb;
wire op_sexth;
wire op_sh;
wire op_sl;
wire op_sr;
wire op_sru;
wire op_sub;
wire op_sw;
wire op_wcsr;
wire op_xnor;
wire op_xor;
wire arith;
wire logical;
wire cmp;
wire bra;
wire call;
wire shift;
wire sext;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
assign op_add    = instruction[ 30:26] ==  5'b01101;
assign op_and    = instruction[ 30:26] ==  5'b01000;
assign op_andhi  = instruction[ 31:26] ==  6'b011000;
assign op_b      = instruction[ 31:26] ==  6'b110000;
assign op_bi     = instruction[ 31:26] ==  6'b111000;
assign op_be     = instruction[ 31:26] ==  6'b010001;
assign op_bg     = instruction[ 31:26] ==  6'b010010;
assign op_bge    = instruction[ 31:26] ==  6'b010011;
assign op_bgeu   = instruction[ 31:26] ==  6'b010100;
assign op_bgu    = instruction[ 31:26] ==  6'b010101;
assign op_bne    = instruction[ 31:26] ==  6'b010111;
assign op_call   = instruction[ 31:26] ==  6'b110110;
assign op_calli  = instruction[ 31:26] ==  6'b111110;
assign op_cmpe   = instruction[ 30:26] ==  5'b11001;
assign op_cmpg   = instruction[ 30:26] ==  5'b11010;
assign op_cmpge  = instruction[ 30:26] ==  5'b11011;
assign op_cmpgeu = instruction[ 30:26] ==  5'b11100;
assign op_cmpgu  = instruction[ 30:26] ==  5'b11101;
assign op_cmpne  = instruction[ 30:26] ==  5'b11111;
assign op_lb     = instruction[ 31:26] ==  6'b000100;
assign op_lbu    = instruction[ 31:26] ==  6'b010000;
assign op_lh     = instruction[ 31:26] ==  6'b000111;
assign op_lhu    = instruction[ 31:26] ==  6'b001011;
assign op_lw     = instruction[ 31:26] ==  6'b001010;
assign op_mul    = instruction[ 30:26] ==  5'b00010;
assign op_nor    = instruction[ 30:26] ==  5'b00001;
assign op_or     = instruction[ 30:26] ==  5'b01110;
assign op_orhi   = instruction[ 31:26] ==  6'b011110;
assign op_raise  = instruction[ 31:26] ==  6'b101011;
assign op_rcsr   = instruction[ 31:26] ==  6'b100100;
assign op_sb     = instruction[ 31:26] ==  6'b001100;
assign op_sextb  = instruction[ 31:26] ==  6'b101100;
assign op_sexth  = instruction[ 31:26] ==  6'b110111;
assign op_sh     = instruction[ 31:26] ==  6'b000011;
assign op_sl     = instruction[ 30:26] ==  5'b01111;      
assign op_sr     = instruction[ 30:26] ==  5'b00101;
assign op_sru    = instruction[ 30:26] ==  5'b00000;
assign op_sub    = instruction[ 31:26] ==  6'b110010;
assign op_sw     = instruction[ 31:26] ==  6'b010110;
assign op_wcsr   = instruction[ 31:26] ==  6'b110100;
assign op_xnor   = instruction[ 30:26] ==  5'b01001;
assign op_xor    = instruction[ 30:26] ==  5'b00110;
assign arith = op_add | op_sub;
assign logical = op_and | op_andhi | op_nor | op_or | op_orhi | op_xor | op_xnor;
assign cmp = op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne;
assign bi_conditional = op_be | op_bg | op_bge | op_bgeu  | op_bgu | op_bne;
assign bi_unconditional = op_bi;
assign bra = op_b | bi_unconditional | bi_conditional;
assign call = op_call | op_calli;
assign shift = op_sl | op_sr | op_sru;
assign sext = op_sextb | op_sexth;
assign load = op_lb | op_lbu | op_lh | op_lhu | op_lw;
assign store = op_sb | op_sh | op_sw;
always @(*)
begin
    if (call) 
        d_result_sel_0 =  1'b1;
    else 
        d_result_sel_0 =  1'b0;
    if (call) 
        d_result_sel_1 =  2'b00;         
    else if ((instruction[31] == 1'b0) && !bra) 
        d_result_sel_1 =  2'b10;
    else
        d_result_sel_1 =  2'b01; 
    x_result_sel_csr =  1'b0;
    x_result_sel_sext =  1'b0;
    x_result_sel_logic =  1'b0;
    x_result_sel_add =  1'b0;
    if (op_rcsr)
        x_result_sel_csr =  1'b1;
    else if (sext)
        x_result_sel_sext =  1'b1;
    else if (logical) 
        x_result_sel_logic =  1'b1;
    else 
        x_result_sel_add =  1'b1;        
    m_result_sel_compare = cmp;
    m_result_sel_shift = shift;
    w_result_sel_load = load;
    w_result_sel_mul = op_mul; 
end
assign x_bypass_enable =  arith 
                        | logical
                        | sext 
                        | op_rcsr
                        ;
assign m_bypass_enable = x_bypass_enable 
                        | shift
                        | cmp
                        ;
assign read_enable_0 = ~(op_bi | op_calli);
assign read_idx_0 = instruction[25:21];
assign read_enable_1 = ~(op_bi | op_calli | load);
assign read_idx_1 = instruction[20:16];
assign write_enable = ~(bra | op_raise | store | op_wcsr);
assign write_idx = call
                    ? 5'd29
                    : instruction[31] == 1'b0 
                        ? instruction[20:16] 
                        : instruction[15:11];
assign size = instruction[27:26];
assign sign_extend = instruction[28];                      
assign adder_op = op_sub | op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne | bra;
assign logic_op = instruction[29:26];
assign direction = instruction[29];
assign branch = bra | call;
assign branch_reg = op_call | op_b;
assign condition = instruction[28:26];      
assign scall = op_raise & instruction[2];
assign eret = op_b & (instruction[25:21] == 5'd30);
assign csr_write_enable = op_wcsr;
assign sign_extend_immediate = ~(op_and | op_cmpgeu | op_cmpgu | op_nor | op_or | op_xnor | op_xor);
assign select_high_immediate = op_andhi | op_orhi;
assign select_call_immediate = instruction[31];
assign high_immediate = {instruction[15:0], 16'h0000};
assign extended_immediate = {{16{sign_extend_immediate & instruction[15]}}, instruction[15:0]};
assign call_immediate = {{6{instruction[25]}}, instruction[25:0]};
assign branch_immediate = {{16{instruction[15]}}, instruction[15:0]};
assign immediate = select_high_immediate ==  1'b1 
                        ? high_immediate 
                        : extended_immediate;
assign branch_offset = select_call_immediate ==  1'b1   
                        ? (call_immediate[ (clogb2(32'h7fffffff-32'h0)-2)-1:0])
                        : (branch_immediate[ (clogb2(32'h7fffffff-32'h0)-2)-1:0]);
endmodule 
module lm32_icache_medium_icache ( 
    clk_i,
    rst_i,    
    stall_a,
    stall_f,
    address_a,
    address_f,
    read_enable_f,
    refill_ready,
    refill_data,
    iflush,
    valid_d,
    branch_predict_taken_d,
    stall_request,
    restart_request,
    refill_request,
    refill_address,
    refilling,
    inst
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = clogb2(bytes_per_line)-1-2;
localparam addr_set_width = clogb2(sets)-1;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
localparam addr_set_lsb = (addr_offset_msb+1);
localparam addr_set_msb = (addr_set_lsb+addr_set_width-1);
localparam addr_tag_lsb = (addr_set_msb+1);
localparam addr_tag_msb = clogb2( 32'h7fffffff- 32'h0)-1;
localparam addr_tag_width = (addr_tag_msb-addr_tag_lsb+1);
input clk_i;                                        
input rst_i;                                        
input stall_a;                                      
input stall_f;                                      
input valid_d;                                      
input branch_predict_taken_d;                       
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] address_a;                     
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] address_f;                     
input read_enable_f;                                
input refill_ready;                                 
input [ (32-1):0] refill_data;          
input iflush;                                       
output stall_request;                               
wire   stall_request;
output restart_request;                             
reg    restart_request;
output refill_request;                              
wire   refill_request;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] refill_address;               
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] refill_address;               
output refilling;                                   
reg    refilling;
output [ (32-1):0] inst;                
wire   [ (32-1):0] inst;
wire enable;
wire [0:associativity-1] way_mem_we;
wire [ (32-1):0] way_data[0:associativity-1];
wire [ ((addr_tag_width+1)-1):1] way_tag[0:associativity-1];
wire [0:associativity-1] way_valid;
wire [0:associativity-1] way_match;
wire miss;
wire [ (addr_set_width-1):0] tmem_read_address;
wire [ (addr_set_width-1):0] tmem_write_address;
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_read_address;
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_write_address;
wire [ ((addr_tag_width+1)-1):0] tmem_write_data;
reg [ 3:0] state;
wire flushing;
wire check;
wire refill;
reg [associativity-1:0] refill_way_select;
reg [ addr_offset_msb:addr_offset_lsb] refill_offset;
wire last_refill;
reg [ (addr_set_width-1):0] flush_set;
genvar i;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
   generate
      for (i = 0; i < associativity; i = i + 1)
	begin : memories
	   lm32_ram 
	     #(
	       .data_width                 (32),
	       .address_width              ( (addr_offset_width+addr_set_width))
) 
	   way_0_data_ram 
	     (
	      .read_clk                   (clk_i),
	      .write_clk                  (clk_i),
	      .reset                      (rst_i),
	      .read_address               (dmem_read_address),
	      .enable_read                (enable),
	      .write_address              (dmem_write_address),
	      .enable_write               ( 1'b1),
	      .write_enable               (way_mem_we[i]),
	      .write_data                 (refill_data),    
	      .read_data                  (way_data[i])
	      );
	   lm32_ram 
	     #(
	       .data_width                 ( (addr_tag_width+1)),
	       .address_width              ( addr_set_width)
	       ) 
	   way_0_tag_ram 
	     (
	      .read_clk                   (clk_i),
	      .write_clk                  (clk_i),
	      .reset                      (rst_i),
	      .read_address               (tmem_read_address),
	      .enable_read                (enable),
	      .write_address              (tmem_write_address),
	      .enable_write               ( 1'b1),
	      .write_enable               (way_mem_we[i] | flushing),
	      .write_data                 (tmem_write_data),
	      .read_data                  ({way_tag[i], way_valid[i]})
	      );
	end
endgenerate
generate
    for (i = 0; i < associativity; i = i + 1)
    begin : match
assign way_match[i] = ({way_tag[i], way_valid[i]} == {address_f[ addr_tag_msb:addr_tag_lsb],  1'b1});
    end
endgenerate
generate
    if (associativity == 1)
    begin : inst_1
assign inst = way_match[0] ? way_data[0] : 32'b0;
    end
    else if (associativity == 2)
	 begin : inst_2
assign inst = way_match[0] ? way_data[0] : (way_match[1] ? way_data[1] : 32'b0);
    end
endgenerate
generate 
    if (bytes_per_line > 4)
assign dmem_write_address = {refill_address[ addr_set_msb:addr_set_lsb], refill_offset};
    else
assign dmem_write_address = refill_address[ addr_set_msb:addr_set_lsb];
endgenerate
assign dmem_read_address = address_a[ addr_set_msb:addr_offset_lsb];
assign tmem_read_address = address_a[ addr_set_msb:addr_set_lsb];
assign tmem_write_address = flushing 
                                ? flush_set
                                : refill_address[ addr_set_msb:addr_set_lsb];
generate 
    if (bytes_per_line > 4)                            
assign last_refill = refill_offset == {addr_offset_width{1'b1}};
    else
assign last_refill =  1'b1;
endgenerate
assign enable = (stall_a ==  1'b0);
generate
    if (associativity == 1) 
    begin : we_1     
assign way_mem_we[0] = (refill_ready ==  1'b1);
    end
    else
    begin : we_2
assign way_mem_we[0] = (refill_ready ==  1'b1) && (refill_way_select[0] ==  1'b1);
assign way_mem_we[1] = (refill_ready ==  1'b1) && (refill_way_select[1] ==  1'b1);
    end
endgenerate                     
assign tmem_write_data[ 0] = last_refill & !flushing;
assign tmem_write_data[ ((addr_tag_width+1)-1):1] = refill_address[ addr_tag_msb:addr_tag_lsb];
assign flushing = |state[1:0];
assign check = state[2];
assign refill = state[3];
assign miss = (~(|way_match)) && (read_enable_f ==  1'b1) && (stall_f ==  1'b0) && !(valid_d && branch_predict_taken_d);
assign stall_request = (check ==  1'b0);
assign refill_request = (refill ==  1'b1);
generate
    if (associativity >= 2) 
    begin : way_select      
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_way_select <= {{associativity-1{1'b0}}, 1'b1};
    else
    begin        
        if (miss ==  1'b1)
            refill_way_select <= {refill_way_select[0], refill_way_select[1]};
    end
end
    end
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refilling <=  1'b0;
    else
        refilling <= refill;
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        state <=  4'b0001;
        flush_set <= { addr_set_width{1'b1}};
        refill_address <= { (clogb2(32'h7fffffff-32'h0)-2){1'bx}};
        restart_request <=  1'b0;
    end
    else 
    begin
        case (state)
         4'b0001:
        begin            
            if (flush_set == { addr_set_width{1'b0}})
                state <=  4'b0100;
            flush_set <= flush_set - 1'b1;
        end
         4'b0010:
        begin            
            if (flush_set == { addr_set_width{1'b0}})
		state <=  4'b0100;
            flush_set <= flush_set - 1'b1;
        end
         4'b0100:
        begin            
            if (stall_a ==  1'b0)
                restart_request <=  1'b0;
            if (iflush ==  1'b1)
            begin
                refill_address <= address_f;
                state <=  4'b0010;
            end
            else if (miss ==  1'b1)
            begin
                refill_address <= address_f;
                state <=  4'b1000;
            end
        end
         4'b1000:
        begin            
            if (refill_ready ==  1'b1)
            begin
                if (last_refill ==  1'b1)
                begin
                    restart_request <=  1'b1;
                    state <=  4'b0100;
                end
            end
        end
        endcase        
    end
end
generate 
    if (bytes_per_line > 4)
    begin
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_offset <= {addr_offset_width{1'b0}};
    else 
    begin
        case (state)
         4'b0100:
        begin            
            if (iflush ==  1'b1)
                refill_offset <= {addr_offset_width{1'b0}};
            else if (miss ==  1'b1)
                refill_offset <= {addr_offset_width{1'b0}};
        end
         4'b1000:
        begin            
            if (refill_ready ==  1'b1)
                refill_offset <= refill_offset + 1'b1;
        end
        endcase        
    end
end
    end
endgenerate
endmodule
module lm32_instruction_unit_medium_icache (
    clk_i,
    rst_i,
    stall_a,
    stall_f,
    stall_d,
    stall_x,
    stall_m,
    valid_f,
    valid_d,
    kill_f,
    branch_predict_taken_d,
    branch_predict_address_d,
    exception_m,
    branch_taken_m,
    branch_mispredict_taken_m,
    branch_target_m,
    iflush,
    i_dat_i,
    i_ack_i,
    i_err_i,
    i_rty_i,
    pc_f,
    pc_d,
    pc_x,
    pc_m,
    pc_w,
    icache_stall_request,
    icache_restart_request,
    icache_refill_request,
    icache_refilling,
    i_dat_o,
    i_adr_o,
    i_cyc_o,
    i_sel_o,
    i_stb_o,
    i_we_o,
    i_cti_o,
    i_lock_o,
    i_bte_o,
    instruction_f,
    instruction_d
    );
parameter eba_reset =  32'h00000000;                   
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam eba_reset_minus_4 = eba_reset - 4;
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_f;                                          
input stall_d;                                          
input stall_x;                                          
input stall_m;                                          
input valid_f;                                          
input valid_d;                                          
input kill_f;                                           
input branch_predict_taken_d;                           
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_predict_address_d;          
input exception_m;
input branch_taken_m;                                   
input branch_mispredict_taken_m;                        
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_m;                   
input iflush;                                           
input [ (32-1):0] i_dat_i;                         
input i_ack_i;                                          
input i_err_i;                                          
input i_rty_i;                                          
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;
output icache_stall_request;                            
wire   icache_stall_request;
output icache_restart_request;                          
wire   icache_restart_request;
output icache_refill_request;                           
wire   icache_refill_request;
output icache_refilling;                                
wire   icache_refilling;
output [ (32-1):0] i_dat_o;                        
wire   [ (32-1):0] i_dat_o;
output [ (32-1):0] i_adr_o;                        
reg    [ (32-1):0] i_adr_o;
output i_cyc_o;                                         
reg    i_cyc_o; 
output [ (4-1):0] i_sel_o;                 
wire   [ (4-1):0] i_sel_o;
output i_stb_o;                                         
reg    i_stb_o;
output i_we_o;                                          
wire   i_we_o;
output [ (3-1):0] i_cti_o;                       
reg    [ (3-1):0] i_cti_o;
output i_lock_o;                                        
reg    i_lock_o;
output [ (2-1):0] i_bte_o;                       
wire   [ (2-1):0] i_bte_o;
output [ (32-1):0] instruction_f;           
wire   [ (32-1):0] instruction_f;
output [ (32-1):0] instruction_d;           
reg    [ (32-1):0] instruction_d;
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_a;                                
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] restart_address;                     
wire icache_read_enable_f;                              
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] icache_refill_address;              
reg icache_refill_ready;                                
reg [ (32-1):0] icache_refill_data;         
wire [ (32-1):0] icache_data_f;             
wire [ (3-1):0] first_cycle_type;                
wire [ (3-1):0] next_cycle_type;                 
wire last_word;                                         
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] first_address;                      
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_icache_medium_icache #(
    .associativity          (associativity),
    .sets                   (sets),
    .bytes_per_line         (bytes_per_line),
    .base_address           (base_address),
    .limit                  (limit)
    ) icache ( 
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),      
    .stall_a                (stall_a),
    .stall_f                (stall_f),
    .branch_predict_taken_d (branch_predict_taken_d),
    .valid_d                (valid_d),
    .address_a              (pc_a),
    .address_f              (pc_f),
    .read_enable_f          (icache_read_enable_f),
    .refill_ready           (icache_refill_ready),
    .refill_data            (icache_refill_data),
    .iflush                 (iflush),
    .stall_request          (icache_stall_request),
    .restart_request        (icache_restart_request),
    .refill_request         (icache_refill_request),
    .refill_address         (icache_refill_address),
    .refilling              (icache_refilling),
    .inst                   (icache_data_f)
    );
assign icache_read_enable_f =    (valid_f ==  1'b1)
                              && (kill_f ==  1'b0)
                              ;
always @(*)
begin
      if (branch_taken_m ==  1'b1)
	if ((branch_mispredict_taken_m ==  1'b1) && (exception_m ==  1'b0))
	  pc_a = pc_x;
	else
          pc_a = branch_target_m;
      else
	if ( (valid_d ==  1'b1) && (branch_predict_taken_d ==  1'b1) )
	  pc_a = branch_predict_address_d;
	else
          if (icache_restart_request ==  1'b1)
            pc_a = restart_address;
	  else 
            pc_a = pc_f + 1'b1;
end
assign instruction_f = icache_data_f;
assign i_dat_o = 32'd0;
assign i_we_o =  1'b0;
assign i_sel_o = 4'b1111;
assign i_bte_o =  2'b00;
generate
    case (bytes_per_line)
    4:
    begin
assign first_cycle_type =  3'b111;
assign next_cycle_type =  3'b111;
assign last_word =  1'b1;
assign first_address = icache_refill_address;
    end
    8:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type =  3'b111;
assign last_word = i_adr_o[addr_offset_msb:addr_offset_lsb] == 1'b1;
assign first_address = {icache_refill_address[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:addr_offset_msb+1], {addr_offset_width{1'b0}}};
    end
    16:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type = i_adr_o[addr_offset_msb] == 1'b1 ?  3'b111 :  3'b010;
assign last_word = i_adr_o[addr_offset_msb:addr_offset_lsb] == 2'b11;
assign first_address = {icache_refill_address[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:addr_offset_msb+1], {addr_offset_width{1'b0}}};
    end
    endcase
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        pc_f <= eba_reset_minus_4[ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2];
        pc_d <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_x <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_m <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_w <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
    end
    else
    begin
        if (stall_f ==  1'b0)
            pc_f <= pc_a;
        if (stall_d ==  1'b0)
            pc_d <= pc_f;
        if (stall_x ==  1'b0)
            pc_x <= pc_d;
        if (stall_m ==  1'b0)
            pc_m <= pc_x;
        pc_w <= pc_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        restart_address <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
    else
    begin
            if (icache_refill_request ==  1'b1)
                restart_address <= icache_refill_address;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        i_cyc_o <=  1'b0;
        i_stb_o <=  1'b0;
        i_adr_o <= { 32{1'b0}};
        i_cti_o <=  3'b111;
        i_lock_o <=  1'b0;
        icache_refill_data <= { 32{1'b0}};
        icache_refill_ready <=  1'b0;
    end
    else
    begin   
        icache_refill_ready <=  1'b0;
        if (i_cyc_o ==  1'b1)
        begin
            if ((i_ack_i ==  1'b1) || (i_err_i ==  1'b1))
            begin
                begin
                    if (last_word ==  1'b1)
                    begin
                        i_cyc_o <=  1'b0;
                        i_stb_o <=  1'b0;
                        i_lock_o <=  1'b0;
                    end
                    i_adr_o[addr_offset_msb:addr_offset_lsb] <= i_adr_o[addr_offset_msb:addr_offset_lsb] + 1'b1;
                    i_cti_o <= next_cycle_type;
                    icache_refill_ready <=  1'b1;
                    icache_refill_data <= i_dat_i;
                end
            end
        end
        else
        begin
            if ((icache_refill_request ==  1'b1) && (icache_refill_ready ==  1'b0))
            begin
                i_adr_o <= {first_address, 2'b00};
                i_cyc_o <=  1'b1;
                i_stb_o <=  1'b1;                
                i_cti_o <= first_cycle_type;
            end
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        instruction_d <= { 32{1'b0}};
    end
    else
    begin
        if (stall_d ==  1'b0)
        begin
            instruction_d <= instruction_f;
        end
    end
end  
endmodule
module lm32_interrupt_medium_icache (
    clk_i, 
    rst_i,
    interrupt,
    stall_x,
    exception,
    eret_q_x,
    csr,
    csr_write_data,
    csr_write_enable,
    interrupt_exception,
    csr_read_data
    );
parameter interrupts =  32;         
input clk_i;                                    
input rst_i;                                    
input [interrupts-1:0] interrupt;               
input stall_x;                                  
input exception;                                
input eret_q_x;                                 
input [ (4 -1):0] csr;                      
input [ (32-1):0] csr_write_data;          
input csr_write_enable;                         
output interrupt_exception;                     
wire   interrupt_exception;
output [ (32-1):0] csr_read_data;          
reg    [ (32-1):0] csr_read_data;
wire [interrupts-1:0] asserted;                 
wire [interrupts-1:0] interrupt_n_exception;
reg ie;                                         
reg eie;                                        
reg [interrupts-1:0] ip;                        
reg [interrupts-1:0] im;                        
assign interrupt_n_exception = ip & im;
assign interrupt_exception = (|interrupt_n_exception) & ie;
assign asserted = ip | interrupt;
generate
    if (interrupts > 1) 
    begin
always @(*)
begin
    case (csr)
     4 'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    1'b0,                                     
                                    eie, 
                                    ie
                                   };
     4 'h2:  csr_read_data = ip;
     4 'h1:  csr_read_data = im;
    default:       csr_read_data = { 32{1'bx}};
    endcase
end
    end
    else
    begin
always @(*)
begin
    case (csr)
     4 'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    1'b0,                                    
                                    eie, 
                                    ie
                                   };
     4 'h2:  csr_read_data = ip;
    default:       csr_read_data = { 32{1'bx}};
      endcase
end
    end
endgenerate
   reg [ 10:0] eie_delay  = 0;
generate
    if (interrupts > 1)
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie                   <=  1'b0;
        eie                  <=  1'b0;
        im                   <= {interrupts{1'b0}};
        ip                   <= {interrupts{1'b0}};
       eie_delay             <= 0;
    end
    else
    begin
        ip                   <= asserted;
        if (exception ==  1'b1)
        begin
            eie              <= ie;
            ie               <=  1'b0;
        end
        else if (stall_x ==  1'b0)
        begin
           if(eie_delay[0])
             ie              <= eie;
           eie_delay         <= {1'b0, eie_delay[ 10:1]};
            if (eret_q_x ==  1'b1) begin
               eie_delay[ 10] <=  1'b1;
               eie_delay[ 10-1:0] <= 0;
            end
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  4 'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                end
                if (csr ==  4 'h1)
                    im  <= csr_write_data[interrupts-1:0];
                if (csr ==  4 'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
else
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie              <=  1'b0;
        eie             <=  1'b0;
        ip              <= {interrupts{1'b0}};
       eie_delay        <= 0;
    end
    else
    begin
        ip              <= asserted;
        if (exception ==  1'b1)
        begin
            eie         <= ie;
            ie          <=  1'b0;
        end
        else if (stall_x ==  1'b0)
          begin
             if(eie_delay[0])
               ie              <= eie;
             eie_delay         <= {1'b0, eie_delay[ 10:1]};
             if (eret_q_x ==  1'b1) begin
                eie_delay[ 10] <=  1'b1;
                eie_delay[ 10-1:0] <= 0;
             end
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  4 'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                end
                if (csr ==  4 'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
endgenerate
endmodule
module lm32_top_medium_icache_debug (
    clk_i,
    rst_i,
    interrupt,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset = 32'h00000000;
parameter sdb_address = 32'h00000000;
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
wire [ 7:0] jtag_reg_d;
wire [ 7:0] jtag_reg_q;
wire jtag_update;
wire [2:0] jtag_reg_addr_d;
wire [2:0] jtag_reg_addr_q;
wire jtck;
wire jrstn;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_cpu_medium_icache_debug 
	#(
		.eba_reset(eba_reset),
    .sdb_address(sdb_address)
	) cpu (
    .clk_i                 (clk_i),
    .rst_i                 (rst_i),
    .interrupt             (interrupt),
    .jtag_clk              (jtck),
    .jtag_update           (jtag_update),
    .jtag_reg_q            (jtag_reg_q),
    .jtag_reg_addr_q       (jtag_reg_addr_q),
    .I_DAT_I               (I_DAT_I),
    .I_ACK_I               (I_ACK_I),
    .I_ERR_I               (I_ERR_I),
    .I_RTY_I               (I_RTY_I),
    .D_DAT_I               (D_DAT_I),
    .D_ACK_I               (D_ACK_I),
    .D_ERR_I               (D_ERR_I),
    .D_RTY_I               (D_RTY_I),
    .jtag_reg_d            (jtag_reg_d),
    .jtag_reg_addr_d       (jtag_reg_addr_d),
    .I_DAT_O               (I_DAT_O),
    .I_ADR_O               (I_ADR_O),
    .I_CYC_O               (I_CYC_O),
    .I_SEL_O               (I_SEL_O),
    .I_STB_O               (I_STB_O),
    .I_WE_O                (I_WE_O),
    .I_CTI_O               (I_CTI_O),
    .I_LOCK_O              (I_LOCK_O),
    .I_BTE_O               (I_BTE_O),
    .D_DAT_O               (D_DAT_O),
    .D_ADR_O               (D_ADR_O),
    .D_CYC_O               (D_CYC_O),
    .D_SEL_O               (D_SEL_O),
    .D_STB_O               (D_STB_O),
    .D_WE_O                (D_WE_O),
    .D_CTI_O               (D_CTI_O),
    .D_LOCK_O              (D_LOCK_O),
    .D_BTE_O               (D_BTE_O)
    );
jtag_cores jtag_cores (
    .reg_d                 (jtag_reg_d),
    .reg_addr_d            (jtag_reg_addr_d),
    .reg_update            (jtag_update),
    .reg_q                 (jtag_reg_q),
    .reg_addr_q            (jtag_reg_addr_q),
    .jtck                  (jtck),
    .jrstn                 (jrstn)
    );
endmodule
module lm32_mc_arithmetic_medium_icache_debug (
    clk_i,
    rst_i,
    stall_d,
    kill_x,
    operand_0_d,
    operand_1_d,
    result_x,
    stall_request_x
    );
input clk_i;                                    
input rst_i;                                    
input stall_d;                                  
input kill_x;                                   
input [ (32-1):0] operand_0_d;
input [ (32-1):0] operand_1_d;
output [ (32-1):0] result_x;               
reg    [ (32-1):0] result_x;
output stall_request_x;                         
wire   stall_request_x;
reg [ (32-1):0] p;                         
reg [ (32-1):0] a;
reg [ (32-1):0] b;
reg [ 2:0] state;                 
reg [5:0] cycles;                               
assign stall_request_x = state !=  3'b000;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        cycles <= {6{1'b0}};
        p <= { 32{1'b0}};
        a <= { 32{1'b0}};
        b <= { 32{1'b0}};
        result_x <= { 32{1'b0}};
        state <=  3'b000;
    end
    else
    begin
        case (state)
         3'b000:
        begin
            if (stall_d ==  1'b0)                 
            begin          
                cycles <=  32;
                p <= 32'b0;
                a <= operand_0_d;
                b <= operand_1_d;                    
            end            
        end
        endcase
    end
end 
endmodule
module lm32_cpu_medium_icache_debug (
    clk_i,
    rst_i,
    interrupt,
    jtag_clk,
    jtag_update, 
    jtag_reg_q,
    jtag_reg_addr_q,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    jtag_reg_d,
    jtag_reg_addr_d,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset =  32'h00000000;                           
parameter deba_reset =  32'h10000000;                         
parameter sdb_address =   32'h00000000;
parameter icache_associativity =  1;     
parameter icache_sets =  256;                       
parameter icache_bytes_per_line =  16;   
parameter icache_base_address =  32'h0;       
parameter icache_limit =  32'h7fffffff;                     
parameter dcache_associativity = 1;    
parameter dcache_sets = 512;                      
parameter dcache_bytes_per_line = 16;  
parameter dcache_base_address = 0;      
parameter dcache_limit = 0;                    
parameter watchpoints =  32'h4;                       
parameter breakpoints = 0;
parameter interrupts =  32;                         
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input jtag_clk;                                 
input jtag_update;                              
input [ 7:0] jtag_reg_q;              
input [2:0] jtag_reg_addr_q;
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ 7:0] jtag_reg_d;
wire   [ 7:0] jtag_reg_d;
output [2:0] jtag_reg_addr_d;
wire   [2:0] jtag_reg_addr_d;
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
reg valid_a;                                    
reg valid_f;                                    
reg valid_d;                                    
reg valid_x;                                    
reg valid_m;                                    
reg valid_w;                                    
wire q_x;
wire [ (32-1):0] immediate_d;              
wire load_d;                                    
reg load_x;                                     
reg load_m;
wire load_q_x;
wire store_q_x;
wire q_m;
wire load_q_m;
wire store_q_m;
wire store_d;                                   
reg store_x;
reg store_m;
wire [ 1:0] size_d;                   
reg [ 1:0] size_x;
wire branch_d;                                  
wire branch_predict_d;                          
wire branch_predict_taken_d;                    
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_predict_address_d;   
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_d;
wire bi_unconditional;
wire bi_conditional;
reg branch_x;                                   
reg branch_predict_x;
reg branch_predict_taken_x;
reg branch_m;
reg branch_predict_m;
reg branch_predict_taken_m;
wire branch_mispredict_taken_m;                 
wire branch_flushX_m;                           
wire branch_reg_d;                              
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset_d;            
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_x;             
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_m;
wire [ 0:0] d_result_sel_0_d; 
wire [ 1:0] d_result_sel_1_d; 
wire x_result_sel_csr_d;                        
reg x_result_sel_csr_x;
wire x_result_sel_sext_d;                       
reg x_result_sel_sext_x;
wire x_result_sel_logic_d;                      
wire x_result_sel_add_d;                        
reg x_result_sel_add_x;
wire m_result_sel_compare_d;                    
reg m_result_sel_compare_x;
reg m_result_sel_compare_m;
wire m_result_sel_shift_d;                      
reg m_result_sel_shift_x;
reg m_result_sel_shift_m;
wire w_result_sel_load_d;                       
reg w_result_sel_load_x;
reg w_result_sel_load_m;
reg w_result_sel_load_w;
wire w_result_sel_mul_d;                        
reg w_result_sel_mul_x;
reg w_result_sel_mul_m;
reg w_result_sel_mul_w;
wire x_bypass_enable_d;                         
reg x_bypass_enable_x;                          
wire m_bypass_enable_d;                         
reg m_bypass_enable_x;                          
reg m_bypass_enable_m;
wire sign_extend_d;                             
reg sign_extend_x;
wire write_enable_d;                            
reg write_enable_x;
wire write_enable_q_x;
reg write_enable_m;
wire write_enable_q_m;
reg write_enable_w;
wire write_enable_q_w;
wire read_enable_0_d;                           
wire [ (5-1):0] read_idx_0_d;          
wire read_enable_1_d;                           
wire [ (5-1):0] read_idx_1_d;          
wire [ (5-1):0] write_idx_d;           
reg [ (5-1):0] write_idx_x;            
reg [ (5-1):0] write_idx_m;
reg [ (5-1):0] write_idx_w;
wire [ (5-1):0] csr_d;                     
reg  [ (5-1):0] csr_x;                  
wire [ (3-1):0] condition_d;         
reg [ (3-1):0] condition_x;          
wire break_d;                                   
reg break_x;                                    
wire scall_d;                                   
reg scall_x;    
wire eret_d;                                    
reg eret_x;
wire eret_q_x;
wire bret_d;                                    
reg bret_x;
wire bret_q_x;
wire csr_write_enable_d;                        
reg csr_write_enable_x;
wire csr_write_enable_q_x;
reg [ (32-1):0] d_result_0;                
reg [ (32-1):0] d_result_1;                
reg [ (32-1):0] x_result;                  
reg [ (32-1):0] m_result;                  
reg [ (32-1):0] w_result;                  
reg [ (32-1):0] operand_0_x;               
reg [ (32-1):0] operand_1_x;               
reg [ (32-1):0] store_operand_x;           
reg [ (32-1):0] operand_m;                 
reg [ (32-1):0] operand_w;                 
reg [ (32-1):0] reg_data_live_0;          
reg [ (32-1):0] reg_data_live_1;  
reg use_buf;                                    
reg [ (32-1):0] reg_data_buf_0;
reg [ (32-1):0] reg_data_buf_1;
wire [ (32-1):0] reg_data_0;               
wire [ (32-1):0] reg_data_1;               
reg [ (32-1):0] bypass_data_0;             
reg [ (32-1):0] bypass_data_1;             
wire reg_write_enable_q_w;
reg interlock;                                  
wire stall_a;                                   
wire stall_f;                                   
wire stall_d;                                   
wire stall_x;                                   
wire stall_m;                                   
wire adder_op_d;                                
reg adder_op_x;                                 
reg adder_op_x_n;                               
wire [ (32-1):0] adder_result_x;           
wire adder_overflow_x;                          
wire adder_carry_n_x;                           
wire [ 3:0] logic_op_d;           
reg [ 3:0] logic_op_x;            
wire [ (32-1):0] logic_result_x;           
wire [ (32-1):0] sextb_result_x;           
wire [ (32-1):0] sexth_result_x;           
wire [ (32-1):0] sext_result_x;            
wire direction_d;                               
reg direction_x;                                        
wire [ (32-1):0] shifter_result_m;         
wire [ (32-1):0] multiplier_result_w;      
wire [ (32-1):0] interrupt_csr_read_data_x;
wire [ (32-1):0] cfg;                      
wire [ (32-1):0] cfg2;                     
reg [ (32-1):0] csr_read_data_x;           
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;                       
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;                       
wire [ (32-1):0] instruction_f;     
wire [ (32-1):0] instruction_d;     
wire iflush;                                    
wire icache_stall_request;                      
wire icache_restart_request;                    
wire icache_refill_request;                     
wire icache_refilling;                          
wire [ (32-1):0] load_data_w;              
wire stall_wb_load;                             
wire [ (32-1):0] jtx_csr_read_data;        
wire [ (32-1):0] jrx_csr_read_data;        
wire jtag_csr_write_enable;                     
wire [ (32-1):0] jtag_csr_write_data;      
wire [ (5-1):0] jtag_csr;                  
wire jtag_read_enable;                          
wire [ 7:0] jtag_read_data;
wire jtag_write_enable;
wire [ 7:0] jtag_write_data;
wire [ (32-1):0] jtag_address;
wire jtag_access_complete;
wire jtag_break;                                
wire raw_x_0;                                   
wire raw_x_1;                                   
wire raw_m_0;                                   
wire raw_m_1;                                   
wire raw_w_0;                                   
wire raw_w_1;                                   
wire cmp_zero;                                  
wire cmp_negative;                              
wire cmp_overflow;                              
wire cmp_carry_n;                               
reg condition_met_x;                            
reg condition_met_m;
wire branch_taken_m;                            
wire kill_f;                                    
wire kill_d;                                    
wire kill_x;                                    
wire kill_m;                                    
wire kill_w;                                    
reg [ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8] eba;                 
reg [ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8] deba;                
reg [ (3-1):0] eid_x;                      
wire dc_ss;                                     
wire dc_re;                                     
wire bp_match;
wire wp_match;
wire exception_x;                               
reg exception_m;                                
wire debug_exception_x;                         
reg debug_exception_m;
reg debug_exception_w;
wire debug_exception_q_w;
wire non_debug_exception_x;                     
reg non_debug_exception_m;
reg non_debug_exception_w;
wire non_debug_exception_q_w;
wire reset_exception;                           
wire interrupt_exception;                       
wire breakpoint_exception;                      
wire watchpoint_exception;                      
wire system_call_exception;                     
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_instruction_unit_medium_icache_debug #(
    .eba_reset              (eba_reset),
    .associativity          (icache_associativity),
    .sets                   (icache_sets),
    .bytes_per_line         (icache_bytes_per_line),
    .base_address           (icache_base_address),
    .limit                  (icache_limit)
  ) instruction_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_f                (stall_f),
    .stall_d                (stall_d),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .valid_f                (valid_f),
    .valid_d                (valid_d),
    .kill_f                 (kill_f),
    .branch_predict_taken_d (branch_predict_taken_d),
    .branch_predict_address_d (branch_predict_address_d),
    .exception_m            (exception_m),
    .branch_taken_m         (branch_taken_m),
    .branch_mispredict_taken_m (branch_mispredict_taken_m),
    .branch_target_m        (branch_target_m),
    .iflush                 (iflush),
    .i_dat_i                (I_DAT_I),
    .i_ack_i                (I_ACK_I),
    .i_err_i                (I_ERR_I),
    .i_rty_i                (I_RTY_I),
    .jtag_read_enable       (jtag_read_enable),
    .jtag_write_enable      (jtag_write_enable),
    .jtag_write_data        (jtag_write_data),
    .jtag_address           (jtag_address),
    .pc_f                   (pc_f),
    .pc_d                   (pc_d),
    .pc_x                   (pc_x),
    .pc_m                   (pc_m),
    .pc_w                   (pc_w),
    .icache_stall_request   (icache_stall_request),
    .icache_restart_request (icache_restart_request),
    .icache_refill_request  (icache_refill_request),
    .icache_refilling       (icache_refilling),
    .i_dat_o                (I_DAT_O),
    .i_adr_o                (I_ADR_O),
    .i_cyc_o                (I_CYC_O),
    .i_sel_o                (I_SEL_O),
    .i_stb_o                (I_STB_O),
    .i_we_o                 (I_WE_O),
    .i_cti_o                (I_CTI_O),
    .i_lock_o               (I_LOCK_O),
    .i_bte_o                (I_BTE_O),
    .jtag_read_data         (jtag_read_data),
    .jtag_access_complete   (jtag_access_complete),
    .instruction_f          (instruction_f),
    .instruction_d          (instruction_d)
    );
lm32_decoder_medium_icache_debug decoder (
    .instruction            (instruction_d),
    .d_result_sel_0         (d_result_sel_0_d),
    .d_result_sel_1         (d_result_sel_1_d),
    .x_result_sel_csr       (x_result_sel_csr_d),
    .x_result_sel_sext      (x_result_sel_sext_d),
    .x_result_sel_logic     (x_result_sel_logic_d),
    .x_result_sel_add       (x_result_sel_add_d),
    .m_result_sel_compare   (m_result_sel_compare_d),
    .m_result_sel_shift     (m_result_sel_shift_d),  
    .w_result_sel_load      (w_result_sel_load_d),
    .w_result_sel_mul       (w_result_sel_mul_d),
    .x_bypass_enable        (x_bypass_enable_d),
    .m_bypass_enable        (m_bypass_enable_d),
    .read_enable_0          (read_enable_0_d),
    .read_idx_0             (read_idx_0_d),
    .read_enable_1          (read_enable_1_d),
    .read_idx_1             (read_idx_1_d),
    .write_enable           (write_enable_d),
    .write_idx              (write_idx_d),
    .immediate              (immediate_d),
    .branch_offset          (branch_offset_d),
    .load                   (load_d),
    .store                  (store_d),
    .size                   (size_d),
    .sign_extend            (sign_extend_d),
    .adder_op               (adder_op_d),
    .logic_op               (logic_op_d),
    .direction              (direction_d),
    .branch                 (branch_d),
    .bi_unconditional       (bi_unconditional),
    .bi_conditional         (bi_conditional),
    .branch_reg             (branch_reg_d),
    .condition              (condition_d),
    .break_opcode           (break_d),
    .scall                  (scall_d),
    .eret                   (eret_d),
    .bret                   (bret_d),
    .csr_write_enable       (csr_write_enable_d)
    ); 
lm32_load_store_unit_medium_icache_debug #(
    .associativity          (dcache_associativity),
    .sets                   (dcache_sets),
    .bytes_per_line         (dcache_bytes_per_line),
    .base_address           (dcache_base_address),
    .limit                  (dcache_limit)
  ) load_store_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .kill_x                 (kill_x),
    .kill_m                 (kill_m),
    .exception_m            (exception_m),
    .store_operand_x        (store_operand_x),
    .load_store_address_x   (adder_result_x),
    .load_store_address_m   (operand_m),
    .load_store_address_w   (operand_w[1:0]),
    .load_x                 (load_x),
    .store_x                (store_x),
    .load_q_x               (load_q_x),
    .store_q_x              (store_q_x),
    .load_q_m               (load_q_m),
    .store_q_m              (store_q_m),
    .sign_extend_x          (sign_extend_x),
    .size_x                 (size_x),
    .d_dat_i                (D_DAT_I),
    .d_ack_i                (D_ACK_I),
    .d_err_i                (D_ERR_I),
    .d_rty_i                (D_RTY_I),
    .load_data_w            (load_data_w),
    .stall_wb_load          (stall_wb_load),
    .d_dat_o                (D_DAT_O),
    .d_adr_o                (D_ADR_O),
    .d_cyc_o                (D_CYC_O),
    .d_sel_o                (D_SEL_O),
    .d_stb_o                (D_STB_O),
    .d_we_o                 (D_WE_O),
    .d_cti_o                (D_CTI_O),
    .d_lock_o               (D_LOCK_O),
    .d_bte_o                (D_BTE_O)
    );      
lm32_adder adder (
    .adder_op_x             (adder_op_x),
    .adder_op_x_n           (adder_op_x_n),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .adder_result_x         (adder_result_x),
    .adder_carry_n_x        (adder_carry_n_x),
    .adder_overflow_x       (adder_overflow_x)
    );
lm32_logic_op logic_op (
    .logic_op_x             (logic_op_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .logic_result_x         (logic_result_x)
    );
lm32_shifter shifter (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .direction_x            (direction_x),
    .sign_extend_x          (sign_extend_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .shifter_result_m       (shifter_result_m)
    );
lm32_multiplier multiplier (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .operand_0              (d_result_0),
    .operand_1              (d_result_1),
    .result                 (multiplier_result_w)    
    );
lm32_interrupt_medium_icache_debug interrupt_unit (
    .clk_i                  (clk_i), 
    .rst_i                  (rst_i),
    .interrupt              (interrupt),
    .stall_x                (stall_x),
    .non_debug_exception    (non_debug_exception_q_w), 
    .debug_exception        (debug_exception_q_w),
    .eret_q_x               (eret_q_x),
    .bret_q_x               (bret_q_x),
    .csr                    (csr_x),
    .csr_write_data         (operand_1_x),
    .csr_write_enable       (csr_write_enable_q_x),
    .interrupt_exception    (interrupt_exception),
    .csr_read_data          (interrupt_csr_read_data_x)
    );
lm32_jtag_medium_icache_debug jtag (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .jtag_clk               (jtag_clk),
    .jtag_update            (jtag_update),
    .jtag_reg_q             (jtag_reg_q),
    .jtag_reg_addr_q        (jtag_reg_addr_q),
    .csr                    (csr_x),
    .csr_write_data         (operand_1_x),
    .csr_write_enable       (csr_write_enable_q_x),
    .stall_x                (stall_x),
    .jtag_read_data         (jtag_read_data),
    .jtag_access_complete   (jtag_access_complete),
    .exception_q_w          (debug_exception_q_w || non_debug_exception_q_w),
    .jtx_csr_read_data      (jtx_csr_read_data),
    .jrx_csr_read_data      (jrx_csr_read_data),
    .jtag_csr_write_enable  (jtag_csr_write_enable),
    .jtag_csr_write_data    (jtag_csr_write_data),
    .jtag_csr               (jtag_csr),
    .jtag_read_enable       (jtag_read_enable),
    .jtag_write_enable      (jtag_write_enable),
    .jtag_write_data        (jtag_write_data),
    .jtag_address           (jtag_address),
    .jtag_break             (jtag_break),
    .jtag_reset             (reset_exception),
    .jtag_reg_d             (jtag_reg_d),
    .jtag_reg_addr_d        (jtag_reg_addr_d)
    );
lm32_debug_medium_icache_debug #(
    .breakpoints            (breakpoints),
    .watchpoints            (watchpoints)
  ) hw_debug (
    .clk_i                  (clk_i), 
    .rst_i                  (rst_i),
    .pc_x                   (pc_x),
    .load_x                 (load_x),
    .store_x                (store_x),
    .load_store_address_x   (adder_result_x),
    .csr_write_enable_x     (csr_write_enable_q_x),
    .csr_write_data         (operand_1_x),
    .csr_x                  (csr_x),
    .jtag_csr_write_enable  (jtag_csr_write_enable),
    .jtag_csr_write_data    (jtag_csr_write_data),
    .jtag_csr               (jtag_csr),
    .eret_q_x               (eret_q_x),
    .bret_q_x               (bret_q_x),
    .stall_x                (stall_x),
    .exception_x            (exception_x),
    .q_x                    (q_x),
    .dc_ss                  (dc_ss),
    .dc_re                  (dc_re),
    .bp_match               (bp_match),
    .wp_match               (wp_match)
    );
   wire [31:0] regfile_data_0, regfile_data_1;
   reg [31:0]  w_result_d;
   reg 	       regfile_raw_0, regfile_raw_0_nxt;
   reg 	       regfile_raw_1, regfile_raw_1_nxt;
   always @(reg_write_enable_q_w or write_idx_w or instruction_f)
     begin
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[25:21]))
	  regfile_raw_0_nxt = 1'b1;
	else
	  regfile_raw_0_nxt = 1'b0;
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[20:16]))
	  regfile_raw_1_nxt = 1'b1;
	else
	  regfile_raw_1_nxt = 1'b0;
     end
   always @(regfile_raw_0 or w_result_d or regfile_data_0)
     if (regfile_raw_0)
       reg_data_live_0 = w_result_d;
     else
       reg_data_live_0 = regfile_data_0;
   always @(regfile_raw_1 or w_result_d or regfile_data_1)
     if (regfile_raw_1)
       reg_data_live_1 = w_result_d;
     else
       reg_data_live_1 = regfile_data_1;
   always @(posedge clk_i  )
     if (rst_i ==  1'b1)
       begin
	  regfile_raw_0 <= 1'b0;
	  regfile_raw_1 <= 1'b0;
	  w_result_d <= 32'b0;
       end
     else
       begin
	  regfile_raw_0 <= regfile_raw_0_nxt;
	  regfile_raw_1 <= regfile_raw_1_nxt;
	  w_result_d <= w_result;
       end
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_0
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[25:21]),
      .rdata_o	(regfile_data_0)
      );
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_1
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[20:16]),
      .rdata_o	(regfile_data_1)
      );
assign reg_data_0 = use_buf ? reg_data_buf_0 : reg_data_live_0;
assign reg_data_1 = use_buf ? reg_data_buf_1 : reg_data_live_1;
assign raw_x_0 = (write_idx_x == read_idx_0_d) && (write_enable_q_x ==  1'b1);
assign raw_m_0 = (write_idx_m == read_idx_0_d) && (write_enable_q_m ==  1'b1);
assign raw_w_0 = (write_idx_w == read_idx_0_d) && (write_enable_q_w ==  1'b1);
assign raw_x_1 = (write_idx_x == read_idx_1_d) && (write_enable_q_x ==  1'b1);
assign raw_m_1 = (write_idx_m == read_idx_1_d) && (write_enable_q_m ==  1'b1);
assign raw_w_1 = (write_idx_w == read_idx_1_d) && (write_enable_q_w ==  1'b1);
always @(*)
begin
    if (   (   (x_bypass_enable_x ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_x_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_x_1 ==  1'b1))
               )
           )
        || (   (m_bypass_enable_m ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_m_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_m_1 ==  1'b1))
               )
           )
       )
        interlock =  1'b1;
    else
        interlock =  1'b0;
end
always @(*)
begin
    if (raw_x_0 ==  1'b1)        
        bypass_data_0 = x_result;
    else if (raw_m_0 ==  1'b1)
        bypass_data_0 = m_result;
    else if (raw_w_0 ==  1'b1)
        bypass_data_0 = w_result;
    else
        bypass_data_0 = reg_data_0;
end
always @(*)
begin
    if (raw_x_1 ==  1'b1)
        bypass_data_1 = x_result;
    else if (raw_m_1 ==  1'b1)
        bypass_data_1 = m_result;
    else if (raw_w_1 ==  1'b1)
        bypass_data_1 = w_result;
    else
        bypass_data_1 = reg_data_1;
end
   assign branch_predict_d = bi_unconditional | bi_conditional;
   assign branch_predict_taken_d = bi_unconditional ? 1'b1 : (bi_conditional ? instruction_d[15] : 1'b0);
   assign branch_target_d = pc_d + branch_offset_d;
   assign branch_predict_address_d = branch_predict_taken_d ? branch_target_d : pc_f;
always @(*)
begin
    d_result_0 = d_result_sel_0_d[0] ? {pc_f, 2'b00} : bypass_data_0; 
    case (d_result_sel_1_d)
     2'b00:      d_result_1 = { 32{1'b0}};
     2'b01:     d_result_1 = bypass_data_1;
     2'b10: d_result_1 = immediate_d;
    default:                        d_result_1 = { 32{1'bx}};
    endcase
end
assign sextb_result_x = {{24{operand_0_x[7]}}, operand_0_x[7:0]};
assign sexth_result_x = {{16{operand_0_x[15]}}, operand_0_x[15:0]};
assign sext_result_x = size_x ==  2'b00 ? sextb_result_x : sexth_result_x;
assign cmp_zero = operand_0_x == operand_1_x;
assign cmp_negative = adder_result_x[ 32-1];
assign cmp_overflow = adder_overflow_x;
assign cmp_carry_n = adder_carry_n_x;
always @(*)
begin
    case (condition_x)
     3'b000:   condition_met_x =  1'b1;
     3'b110:   condition_met_x =  1'b1;
     3'b001:    condition_met_x = cmp_zero;
     3'b111:   condition_met_x = !cmp_zero;
     3'b010:    condition_met_x = !cmp_zero && (cmp_negative == cmp_overflow);
     3'b101:   condition_met_x = cmp_carry_n && !cmp_zero;
     3'b011:   condition_met_x = cmp_negative == cmp_overflow;
     3'b100:  condition_met_x = cmp_carry_n;
    default:              condition_met_x = 1'bx;
    endcase 
end
always @(*)
begin
    x_result =   x_result_sel_add_x ? adder_result_x 
               : x_result_sel_csr_x ? csr_read_data_x
               : x_result_sel_sext_x ? sext_result_x
               : logic_result_x;
end
always @(*)
begin
    m_result =   m_result_sel_compare_m ? {{ 32-1{1'b0}}, condition_met_m}
               : m_result_sel_shift_m ? shifter_result_m
               : operand_m; 
end
always @(*)
begin
    w_result =    w_result_sel_load_w ? load_data_w
                : w_result_sel_mul_w ? multiplier_result_w
                : operand_w;
end
assign branch_taken_m =      (stall_m ==  1'b0) 
                          && (   (   (branch_m ==  1'b1) 
                                  && (valid_m ==  1'b1)
                                  && (   (   (condition_met_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b0)
					 )
				      || (   (condition_met_m ==  1'b0)
					  && (branch_predict_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b1)
					 )
				     )
                                 ) 
                              || (exception_m ==  1'b1)
                             );
assign branch_mispredict_taken_m =    (condition_met_m ==  1'b0)
                                   && (branch_predict_m ==  1'b1)
	   			   && (branch_predict_taken_m ==  1'b1);
assign branch_flushX_m =    (stall_m ==  1'b0)
                         && (   (   (branch_m ==  1'b1) 
                                 && (valid_m ==  1'b1)
			         && (   (condition_met_m ==  1'b1)
				     || (   (condition_met_m ==  1'b0)
					 && (branch_predict_m ==  1'b1)
					 && (branch_predict_taken_m ==  1'b1)
					)
				    )
			        )
			     || (exception_m ==  1'b1)
			    );
assign kill_f =    (   (valid_d ==  1'b1)
                    && (branch_predict_taken_d ==  1'b1)
		   )
                || (branch_taken_m ==  1'b1) 
                || (icache_refill_request ==  1'b1) 
                ;
assign kill_d =    (branch_taken_m ==  1'b1) 
                || (icache_refill_request ==  1'b1)     
                ;
assign kill_x =    (branch_flushX_m ==  1'b1) 
                ;
assign kill_m =     1'b0
                ;                
assign kill_w =     1'b0
                ;
assign breakpoint_exception =    (   (   (break_x ==  1'b1)
				      || (bp_match ==  1'b1)
				     )
				  && (valid_x ==  1'b1)
				 )
                              || (jtag_break ==  1'b1)
                              ;
assign watchpoint_exception = wp_match ==  1'b1;
assign system_call_exception = (   (scall_x ==  1'b1)
			       );
assign debug_exception_x =  (breakpoint_exception ==  1'b1)
                         || (watchpoint_exception ==  1'b1)
                         ;
assign non_debug_exception_x = (system_call_exception ==  1'b1)
                            || (reset_exception ==  1'b1)
                            || (   (interrupt_exception ==  1'b1)
                                && (dc_ss ==  1'b0)
                               )
                            ;
assign exception_x = (debug_exception_x ==  1'b1) || (non_debug_exception_x ==  1'b1);
always @(*)
begin
    if (reset_exception ==  1'b1)
        eid_x =  3'h0;
    else
         if (breakpoint_exception ==  1'b1)
        eid_x =  3'd1;
    else
         if (watchpoint_exception ==  1'b1)
        eid_x =  3'd3;
    else 
         if (   (interrupt_exception ==  1'b1)
             && (dc_ss ==  1'b0)
            )
        eid_x =  3'h6;
    else
        eid_x =  3'h7;
end
assign stall_a = (stall_f ==  1'b1);
assign stall_f = (stall_d ==  1'b1);
assign stall_d =   (stall_x ==  1'b1) 
                || (   (interlock ==  1'b1)
                    && (kill_d ==  1'b0)
                   ) 
		|| (   (   (eret_d ==  1'b1)
			|| (scall_d ==  1'b1)
		       )
		    && (   (load_q_x ==  1'b1)
			|| (load_q_m ==  1'b1)
			|| (store_q_x ==  1'b1)
			|| (store_q_m ==  1'b1)
			|| (D_CYC_O ==  1'b1)
		       )
                    && (kill_d ==  1'b0)
		   )
		|| (   (   (break_d ==  1'b1)
			|| (bret_d ==  1'b1)
		       )
		    && (   (load_q_x ==  1'b1)
			|| (store_q_x ==  1'b1)
			|| (load_q_m ==  1'b1)
			|| (store_q_m ==  1'b1)
			|| (D_CYC_O ==  1'b1)
		       )
                    && (kill_d ==  1'b0)
		   )
                || (   (csr_write_enable_d ==  1'b1)
                    && (load_q_x ==  1'b1)
                   )                      
                ;
assign stall_x =    (stall_m ==  1'b1)
                 ;
assign stall_m =    (stall_wb_load ==  1'b1)
                 || (   (D_CYC_O ==  1'b1)
                     && (   (store_m ==  1'b1)
		         || ((store_x ==  1'b1) && (interrupt_exception ==  1'b1))
                         || (load_m ==  1'b1)
                         || (load_x ==  1'b1)
                        ) 
                    ) 
                 || (icache_stall_request ==  1'b1)     
                 || ((I_CYC_O ==  1'b1) && ((branch_m ==  1'b1) || (exception_m ==  1'b1))) 
                 ;      
assign q_x = (valid_x ==  1'b1) && (kill_x ==  1'b0);
assign csr_write_enable_q_x = (csr_write_enable_x ==  1'b1) && (q_x ==  1'b1);
assign eret_q_x = (eret_x ==  1'b1) && (q_x ==  1'b1);
assign bret_q_x = (bret_x ==  1'b1) && (q_x ==  1'b1);
assign load_q_x = (load_x ==  1'b1) 
               && (q_x ==  1'b1)
               && (bp_match ==  1'b0)
                  ;
assign store_q_x = (store_x ==  1'b1) 
               && (q_x ==  1'b1)
               && (bp_match ==  1'b0)
                  ;
assign q_m = (valid_m ==  1'b1) && (kill_m ==  1'b0) && (exception_m ==  1'b0);
assign load_q_m = (load_m ==  1'b1) && (q_m ==  1'b1);
assign store_q_m = (store_m ==  1'b1) && (q_m ==  1'b1);
assign debug_exception_q_w = ((debug_exception_w ==  1'b1) && (valid_w ==  1'b1));
assign non_debug_exception_q_w = ((non_debug_exception_w ==  1'b1) && (valid_w ==  1'b1));        
assign write_enable_q_x = (write_enable_x ==  1'b1) && (valid_x ==  1'b1) && (branch_flushX_m ==  1'b0);
assign write_enable_q_m = (write_enable_m ==  1'b1) && (valid_m ==  1'b1);
assign write_enable_q_w = (write_enable_w ==  1'b1) && (valid_w ==  1'b1);
assign reg_write_enable_q_w = (write_enable_w ==  1'b1) && (kill_w ==  1'b0) && (valid_w ==  1'b1);
assign cfg = {
               6'h02,
              watchpoints[3:0],
              breakpoints[3:0],
              interrupts[5:0],
               1'b1,
               1'b0,
               1'b1,
               1'b1,
               1'b1,
               1'b0,
               1'b0,
               1'b0,
               1'b1,
               1'b1,
               1'b0,
               1'b1
              };
assign cfg2 = {
		     30'b0,
		      1'b0,
		      1'b0
		     };
assign iflush = (   (csr_write_enable_d ==  1'b1) 
                 && (csr_d ==  5'h3)
                 && (stall_d ==  1'b0)
                 && (kill_d ==  1'b0)
                 && (valid_d ==  1'b1))
             ||
                (   (jtag_csr_write_enable ==  1'b1)
		 && (jtag_csr ==  5'h3))
		 ;
assign csr_d = read_idx_0_d[ (5-1):0];
always @(*)
begin
    case (csr_x)
     5'h0,
     5'h1,
     5'h2:   csr_read_data_x = interrupt_csr_read_data_x;  
     5'h6:  csr_read_data_x = cfg;
     5'h7:  csr_read_data_x = {eba, 8'h00};
     5'h9: csr_read_data_x = {deba, 8'h00};
     5'he:  csr_read_data_x = jtx_csr_read_data;  
     5'hf:  csr_read_data_x = jrx_csr_read_data;
     5'ha: csr_read_data_x = cfg2;
     5'hb:  csr_read_data_x = sdb_address;
    default:        csr_read_data_x = { 32{1'bx}};
    endcase
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        eba <= eba_reset[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    else
    begin
        if ((csr_write_enable_q_x ==  1'b1) && (csr_x ==  5'h7) && (stall_x ==  1'b0))
            eba <= operand_1_x[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
        if ((jtag_csr_write_enable ==  1'b1) && (jtag_csr ==  5'h7))
            eba <= jtag_csr_write_data[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        deba <= deba_reset[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    else
    begin
        if ((csr_write_enable_q_x ==  1'b1) && (csr_x ==  5'h9) && (stall_x ==  1'b0))
            deba <= operand_1_x[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
        if ((jtag_csr_write_enable ==  1'b1) && (jtag_csr ==  5'h9))
            deba <= jtag_csr_write_data[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:8];
    end
end
always @(*)
begin
    if (icache_refill_request ==  1'b1) 
        valid_a =  1'b0;
    else if (icache_restart_request ==  1'b1) 
        valid_a =  1'b1;
    else 
        valid_a = !icache_refilling;
end 
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        valid_f <=  1'b0;
        valid_d <=  1'b0;
        valid_x <=  1'b0;
        valid_m <=  1'b0;
        valid_w <=  1'b0;
    end
    else
    begin    
        if ((kill_f ==  1'b1) || (stall_a ==  1'b0))
            valid_f <= valid_a;    
        else if (stall_f ==  1'b0)
            valid_f <=  1'b0;            
        if (kill_d ==  1'b1)
            valid_d <=  1'b0;
        else if (stall_f ==  1'b0)
            valid_d <= valid_f & !kill_f;
        else if (stall_d ==  1'b0)
            valid_d <=  1'b0;
        if (stall_d ==  1'b0)
            valid_x <= valid_d & !kill_d;
        else if (kill_x ==  1'b1)
            valid_x <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_x <=  1'b0;
        if (kill_m ==  1'b1)
            valid_m <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_m <= valid_x & !kill_x;
        else if (stall_m ==  1'b0)
            valid_m <=  1'b0;
        if (stall_m ==  1'b0)
            valid_w <= valid_m & !kill_m;
        else 
            valid_w <=  1'b0;        
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        operand_0_x <= { 32{1'b0}};
        operand_1_x <= { 32{1'b0}};
        store_operand_x <= { 32{1'b0}};
        branch_target_x <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};        
        x_result_sel_csr_x <=  1'b0;
        x_result_sel_sext_x <=  1'b0;
        x_result_sel_add_x <=  1'b0;
        m_result_sel_compare_x <=  1'b0;
        m_result_sel_shift_x <=  1'b0;
        w_result_sel_load_x <=  1'b0;
        w_result_sel_mul_x <=  1'b0;
        x_bypass_enable_x <=  1'b0;
        m_bypass_enable_x <=  1'b0;
        write_enable_x <=  1'b0;
        write_idx_x <= { 5{1'b0}};
        csr_x <= { 5{1'b0}};
        load_x <=  1'b0;
        store_x <=  1'b0;
        size_x <= { 2{1'b0}};
        sign_extend_x <=  1'b0;
        adder_op_x <=  1'b0;
        adder_op_x_n <=  1'b0;
        logic_op_x <= 4'h0;
        direction_x <=  1'b0;
        branch_x <=  1'b0;
        branch_predict_x <=  1'b0;
        branch_predict_taken_x <=  1'b0;
        condition_x <=  3'b000;
        break_x <=  1'b0;
        scall_x <=  1'b0;
        eret_x <=  1'b0;
        bret_x <=  1'b0;
        csr_write_enable_x <=  1'b0;
        operand_m <= { 32{1'b0}};
        branch_target_m <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        m_result_sel_compare_m <=  1'b0;
        m_result_sel_shift_m <=  1'b0;
        w_result_sel_load_m <=  1'b0;
        w_result_sel_mul_m <=  1'b0;
        m_bypass_enable_m <=  1'b0;
        branch_m <=  1'b0;
        branch_predict_m <=  1'b0;
	branch_predict_taken_m <=  1'b0;
        exception_m <=  1'b0;
        load_m <=  1'b0;
        store_m <=  1'b0;
        write_enable_m <=  1'b0;            
        write_idx_m <= { 5{1'b0}};
        condition_met_m <=  1'b0;
        debug_exception_m <=  1'b0;
        non_debug_exception_m <=  1'b0;        
        operand_w <= { 32{1'b0}};        
        w_result_sel_load_w <=  1'b0;
        w_result_sel_mul_w <=  1'b0;
        write_idx_w <= { 5{1'b0}};        
        write_enable_w <=  1'b0;
        debug_exception_w <=  1'b0;
        non_debug_exception_w <=  1'b0;        
    end
    else
    begin
        if (stall_x ==  1'b0)
        begin
            operand_0_x <= d_result_0;
            operand_1_x <= d_result_1;
            store_operand_x <= bypass_data_1;
            branch_target_x <= branch_reg_d ==  1'b1 ? bypass_data_0[ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] : branch_target_d;            
            x_result_sel_csr_x <= x_result_sel_csr_d;
            x_result_sel_sext_x <= x_result_sel_sext_d;
            x_result_sel_add_x <= x_result_sel_add_d;
            m_result_sel_compare_x <= m_result_sel_compare_d;
            m_result_sel_shift_x <= m_result_sel_shift_d;
            w_result_sel_load_x <= w_result_sel_load_d;
            w_result_sel_mul_x <= w_result_sel_mul_d;
            x_bypass_enable_x <= x_bypass_enable_d;
            m_bypass_enable_x <= m_bypass_enable_d;
            load_x <= load_d;
            store_x <= store_d;
            branch_x <= branch_d;
	    branch_predict_x <= branch_predict_d;
	    branch_predict_taken_x <= branch_predict_taken_d;
	    write_idx_x <= write_idx_d;
            csr_x <= csr_d;
            size_x <= size_d;
            sign_extend_x <= sign_extend_d;
            adder_op_x <= adder_op_d;
            adder_op_x_n <= ~adder_op_d;
            logic_op_x <= logic_op_d;
            direction_x <= direction_d;
            condition_x <= condition_d;
            csr_write_enable_x <= csr_write_enable_d;
            break_x <= break_d;
            scall_x <= scall_d;
            eret_x <= eret_d;
            bret_x <= bret_d; 
            write_enable_x <= write_enable_d;
        end
        if (stall_m ==  1'b0)
        begin
            operand_m <= x_result;
            m_result_sel_compare_m <= m_result_sel_compare_x;
            m_result_sel_shift_m <= m_result_sel_shift_x;
            if (exception_x ==  1'b1)
            begin
                w_result_sel_load_m <=  1'b0;
                w_result_sel_mul_m <=  1'b0;
            end
            else
            begin
                w_result_sel_load_m <= w_result_sel_load_x;
                w_result_sel_mul_m <= w_result_sel_mul_x;
            end
            m_bypass_enable_m <= m_bypass_enable_x;
            load_m <= load_x;
            store_m <= store_x;
            branch_m <= branch_x;
	    branch_predict_m <= branch_predict_x;
	    branch_predict_taken_m <= branch_predict_taken_x;
            if (non_debug_exception_x ==  1'b1) 
                write_idx_m <=  5'd30;
            else if (debug_exception_x ==  1'b1)
                write_idx_m <=  5'd31;
            else 
                write_idx_m <= write_idx_x;
            condition_met_m <= condition_met_x;
	   if (exception_x ==  1'b1)
	     if ((dc_re ==  1'b1)
		 || ((debug_exception_x ==  1'b1) 
		     && (non_debug_exception_x ==  1'b0)))
	       branch_target_m <= {deba, eid_x, {3{1'b0}}};
	     else
	       branch_target_m <= {eba, eid_x, {3{1'b0}}};
	   else
	     branch_target_m <= branch_target_x;
            write_enable_m <= exception_x ==  1'b1 ?  1'b1 : write_enable_x;            
            debug_exception_m <= debug_exception_x;
            non_debug_exception_m <= non_debug_exception_x;        
        end
        if (stall_m ==  1'b0)
        begin
            if ((exception_x ==  1'b1) && (q_x ==  1'b1) && (stall_x ==  1'b0))
                exception_m <=  1'b1;
            else 
                exception_m <=  1'b0;
	end
        operand_w <= exception_m ==  1'b1 ? {pc_m, 2'b00} : m_result;
        w_result_sel_load_w <= w_result_sel_load_m;
        w_result_sel_mul_w <= w_result_sel_mul_m;
        write_idx_w <= write_idx_m;
        write_enable_w <= write_enable_m;
        debug_exception_w <= debug_exception_m;
        non_debug_exception_w <= non_debug_exception_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        use_buf <=  1'b0;
        reg_data_buf_0 <= { 32{1'b0}};
        reg_data_buf_1 <= { 32{1'b0}};
    end
    else
    begin
        if (stall_d ==  1'b0)
            use_buf <=  1'b0;
        else if (use_buf ==  1'b0)
        begin        
            reg_data_buf_0 <= reg_data_live_0;
            reg_data_buf_1 <= reg_data_live_1;
            use_buf <=  1'b1;
        end        
        if (reg_write_enable_q_w ==  1'b1)
        begin
            if (write_idx_w == read_idx_0_d)
                reg_data_buf_0 <= w_result;
            if (write_idx_w == read_idx_1_d)
                reg_data_buf_1 <= w_result;
        end
    end
end
initial
begin
end
endmodule 
module lm32_load_store_unit_medium_icache_debug (
    clk_i,
    rst_i,
    stall_a,
    stall_x,
    stall_m,
    kill_x,
    kill_m,
    exception_m,
    store_operand_x,
    load_store_address_x,
    load_store_address_m,
    load_store_address_w,
    load_x,
    store_x,
    load_q_x,
    store_q_x,
    load_q_m,
    store_q_m,
    sign_extend_x,
    size_x,
    d_dat_i,
    d_ack_i,
    d_err_i,
    d_rty_i,
    load_data_w,
    stall_wb_load,
    d_dat_o,
    d_adr_o,
    d_cyc_o,
    d_sel_o,
    d_stb_o,
    d_we_o,
    d_cti_o,
    d_lock_o,
    d_bte_o
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_x;                                          
input stall_m;                                          
input kill_x;                                           
input kill_m;                                           
input exception_m;                                      
input [ (32-1):0] store_operand_x;                 
input [ (32-1):0] load_store_address_x;            
input [ (32-1):0] load_store_address_m;            
input [1:0] load_store_address_w;                       
input load_x;                                           
input store_x;                                          
input load_q_x;                                         
input store_q_x;                                        
input load_q_m;                                         
input store_q_m;                                        
input sign_extend_x;                                    
input [ 1:0] size_x;                          
input [ (32-1):0] d_dat_i;                         
input d_ack_i;                                          
input d_err_i;                                          
input d_rty_i;                                          
output [ (32-1):0] load_data_w;                    
reg    [ (32-1):0] load_data_w;
output stall_wb_load;                                   
reg    stall_wb_load;
output [ (32-1):0] d_dat_o;                        
reg    [ (32-1):0] d_dat_o;
output [ (32-1):0] d_adr_o;                        
reg    [ (32-1):0] d_adr_o;
output d_cyc_o;                                         
reg    d_cyc_o;
output [ (4-1):0] d_sel_o;                 
reg    [ (4-1):0] d_sel_o;
output d_stb_o;                                         
reg    d_stb_o; 
output d_we_o;                                          
reg    d_we_o;
output [ (3-1):0] d_cti_o;                       
reg    [ (3-1):0] d_cti_o;
output d_lock_o;                                        
reg    d_lock_o;
output [ (2-1):0] d_bte_o;                       
wire   [ (2-1):0] d_bte_o;
reg [ 1:0] size_m;
reg [ 1:0] size_w;
reg sign_extend_m;
reg sign_extend_w;
reg [ (32-1):0] store_data_x;       
reg [ (32-1):0] store_data_m;       
reg [ (4-1):0] byte_enable_x;
reg [ (4-1):0] byte_enable_m;
wire [ (32-1):0] data_m;
reg [ (32-1):0] data_w;
wire wb_select_x;                                       
reg wb_select_m;
reg [ (32-1):0] wb_data_m;                         
reg wb_load_complete;                                   
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
   assign wb_select_x =     1'b1
                     ;
always @(*)
begin
    case (size_x)
     2'b00:  store_data_x = {4{store_operand_x[7:0]}};
     2'b11: store_data_x = {2{store_operand_x[15:0]}};
     2'b10:  store_data_x = store_operand_x;    
    default:          store_data_x = { 32{1'bx}};
    endcase
end
always @(*)
begin
    casez ({size_x, load_store_address_x[1:0]})
    { 2'b00, 2'b11}:  byte_enable_x = 4'b0001;
    { 2'b00, 2'b10}:  byte_enable_x = 4'b0010;
    { 2'b00, 2'b01}:  byte_enable_x = 4'b0100;
    { 2'b00, 2'b00}:  byte_enable_x = 4'b1000;
    { 2'b11, 2'b1?}: byte_enable_x = 4'b0011;
    { 2'b11, 2'b0?}: byte_enable_x = 4'b1100;
    { 2'b10, 2'b??}:  byte_enable_x = 4'b1111;
    default:                   byte_enable_x = 4'bxxxx;
    endcase
end
   assign data_m = wb_data_m;
always @(*)
begin
    casez ({size_w, load_store_address_w[1:0]})
    { 2'b00, 2'b11}:  load_data_w = {{24{sign_extend_w & data_w[7]}}, data_w[7:0]};
    { 2'b00, 2'b10}:  load_data_w = {{24{sign_extend_w & data_w[15]}}, data_w[15:8]};
    { 2'b00, 2'b01}:  load_data_w = {{24{sign_extend_w & data_w[23]}}, data_w[23:16]};
    { 2'b00, 2'b00}:  load_data_w = {{24{sign_extend_w & data_w[31]}}, data_w[31:24]};
    { 2'b11, 2'b1?}: load_data_w = {{16{sign_extend_w & data_w[15]}}, data_w[15:0]};
    { 2'b11, 2'b0?}: load_data_w = {{16{sign_extend_w & data_w[31]}}, data_w[31:16]};
    { 2'b10, 2'b??}:  load_data_w = data_w;
    default:                   load_data_w = { 32{1'bx}};
    endcase
end
assign d_bte_o =  2'b00;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        d_cyc_o <=  1'b0;
        d_stb_o <=  1'b0;
        d_dat_o <= { 32{1'b0}};
        d_adr_o <= { 32{1'b0}};
        d_sel_o <= { 4{ 1'b0}};
        d_we_o <=  1'b0;
        d_cti_o <=  3'b111;
        d_lock_o <=  1'b0;
        wb_data_m <= { 32{1'b0}};
        wb_load_complete <=  1'b0;
        stall_wb_load <=  1'b0;
    end
    else
    begin
        if (d_cyc_o ==  1'b1)
        begin
            if ((d_ack_i ==  1'b1) || (d_err_i ==  1'b1))
            begin
                begin
                    d_cyc_o <=  1'b0;
                    d_stb_o <=  1'b0;
                    d_lock_o <=  1'b0;
                end
                wb_data_m <= d_dat_i;
                wb_load_complete <= !d_we_o;
            end
            if (d_err_i ==  1'b1)
                $display ("Data bus error. Address: %x", d_adr_o);
        end
        else
        begin
                 if (   (store_q_m ==  1'b1)
                     && (stall_m ==  1'b0)
                    )
            begin
                d_dat_o <= store_data_m;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b1;
                d_cti_o <=  3'b111;
            end        
            else if (   (load_q_m ==  1'b1) 
                     && (wb_select_m ==  1'b1) 
                     && (wb_load_complete ==  1'b0)
                    )
            begin
                stall_wb_load <=  1'b0;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b0;
                d_cti_o <=  3'b111;
            end
        end
        if (stall_m ==  1'b0)
            wb_load_complete <=  1'b0;
        if ((load_q_x ==  1'b1) && (wb_select_x ==  1'b1) && (stall_x ==  1'b0))
            stall_wb_load <=  1'b1;
        if ((kill_m ==  1'b1) || (exception_m ==  1'b1))
            stall_wb_load <=  1'b0;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        sign_extend_m <=  1'b0;
        size_m <= 2'b00;
        byte_enable_m <=  1'b0;
        store_data_m <= { 32{1'b0}};
        wb_select_m <=  1'b0;        
    end
    else
    begin
        if (stall_m ==  1'b0)
        begin
            sign_extend_m <= sign_extend_x;
            size_m <= size_x;
            byte_enable_m <= byte_enable_x;    
            store_data_m <= store_data_x;
            wb_select_m <= wb_select_x;
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        size_w <= 2'b00;
        data_w <= { 32{1'b0}};
        sign_extend_w <=  1'b0;
    end
    else
    begin
        size_w <= size_m;
        data_w <= data_m;
        sign_extend_w <= sign_extend_m;
    end
end
always @(posedge clk_i)
begin
    if (((load_q_m ==  1'b1) || (store_q_m ==  1'b1)) && (stall_m ==  1'b0)) 
    begin
        if ((size_m ===  2'b11) && (load_store_address_m[0] !== 1'b0))
            $display ("Warning: Non-aligned halfword access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
        if ((size_m ===  2'b10) && (load_store_address_m[1:0] !== 2'b00))
            $display ("Warning: Non-aligned word access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
    end
end
endmodule
module lm32_decoder_medium_icache_debug (
    instruction,
    d_result_sel_0,
    d_result_sel_1,        
    x_result_sel_csr,
    x_result_sel_sext,
    x_result_sel_logic,
    x_result_sel_add,
    m_result_sel_compare,
    m_result_sel_shift,  
    w_result_sel_load,
    w_result_sel_mul,
    x_bypass_enable,
    m_bypass_enable,
    read_enable_0,
    read_idx_0,
    read_enable_1,
    read_idx_1,
    write_enable,
    write_idx,
    immediate,
    branch_offset,
    load,
    store,
    size,
    sign_extend,
    adder_op,
    logic_op,
    direction,
    branch,
    branch_reg,
    condition,
    bi_conditional,
    bi_unconditional,
    break_opcode,
    scall,
    eret,
    bret,
    csr_write_enable
    );
input [ (32-1):0] instruction;       
output [ 0:0] d_result_sel_0;
reg    [ 0:0] d_result_sel_0;
output [ 1:0] d_result_sel_1;
reg    [ 1:0] d_result_sel_1;
output x_result_sel_csr;
reg    x_result_sel_csr;
output x_result_sel_sext;
reg    x_result_sel_sext;
output x_result_sel_logic;
reg    x_result_sel_logic;
output x_result_sel_add;
reg    x_result_sel_add;
output m_result_sel_compare;
reg    m_result_sel_compare;
output m_result_sel_shift;
reg    m_result_sel_shift;
output w_result_sel_load;
reg    w_result_sel_load;
output w_result_sel_mul;
reg    w_result_sel_mul;
output x_bypass_enable;
wire   x_bypass_enable;
output m_bypass_enable;
wire   m_bypass_enable;
output read_enable_0;
wire   read_enable_0;
output [ (5-1):0] read_idx_0;
wire   [ (5-1):0] read_idx_0;
output read_enable_1;
wire   read_enable_1;
output [ (5-1):0] read_idx_1;
wire   [ (5-1):0] read_idx_1;
output write_enable;
wire   write_enable;
output [ (5-1):0] write_idx;
wire   [ (5-1):0] write_idx;
output [ (32-1):0] immediate;
wire   [ (32-1):0] immediate;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset;
wire   [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_offset;
output load;
wire   load;
output store;
wire   store;
output [ 1:0] size;
wire   [ 1:0] size;
output sign_extend;
wire   sign_extend;
output adder_op;
wire   adder_op;
output [ 3:0] logic_op;
wire   [ 3:0] logic_op;
output direction;
wire   direction;
output branch;
wire   branch;
output branch_reg;
wire   branch_reg;
output [ (3-1):0] condition;
wire   [ (3-1):0] condition;
output bi_conditional;
wire bi_conditional;
output bi_unconditional;
wire bi_unconditional;
output break_opcode;
wire   break_opcode;
output scall;
wire   scall;
output eret;
wire   eret;
output bret;
wire   bret;
output csr_write_enable;
wire   csr_write_enable;
wire [ (32-1):0] extended_immediate;       
wire [ (32-1):0] high_immediate;           
wire [ (32-1):0] call_immediate;           
wire [ (32-1):0] branch_immediate;         
wire sign_extend_immediate;                     
wire select_high_immediate;                     
wire select_call_immediate;                     
wire op_add;
wire op_and;
wire op_andhi;
wire op_b;
wire op_bi;
wire op_be;
wire op_bg;
wire op_bge;
wire op_bgeu;
wire op_bgu;
wire op_bne;
wire op_call;
wire op_calli;
wire op_cmpe;
wire op_cmpg;
wire op_cmpge;
wire op_cmpgeu;
wire op_cmpgu;
wire op_cmpne;
wire op_lb;
wire op_lbu;
wire op_lh;
wire op_lhu;
wire op_lw;
wire op_mul;
wire op_nor;
wire op_or;
wire op_orhi;
wire op_raise;
wire op_rcsr;
wire op_sb;
wire op_sextb;
wire op_sexth;
wire op_sh;
wire op_sl;
wire op_sr;
wire op_sru;
wire op_sub;
wire op_sw;
wire op_wcsr;
wire op_xnor;
wire op_xor;
wire arith;
wire logical;
wire cmp;
wire bra;
wire call;
wire shift;
wire sext;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
assign op_add    = instruction[ 30:26] ==  5'b01101;
assign op_and    = instruction[ 30:26] ==  5'b01000;
assign op_andhi  = instruction[ 31:26] ==  6'b011000;
assign op_b      = instruction[ 31:26] ==  6'b110000;
assign op_bi     = instruction[ 31:26] ==  6'b111000;
assign op_be     = instruction[ 31:26] ==  6'b010001;
assign op_bg     = instruction[ 31:26] ==  6'b010010;
assign op_bge    = instruction[ 31:26] ==  6'b010011;
assign op_bgeu   = instruction[ 31:26] ==  6'b010100;
assign op_bgu    = instruction[ 31:26] ==  6'b010101;
assign op_bne    = instruction[ 31:26] ==  6'b010111;
assign op_call   = instruction[ 31:26] ==  6'b110110;
assign op_calli  = instruction[ 31:26] ==  6'b111110;
assign op_cmpe   = instruction[ 30:26] ==  5'b11001;
assign op_cmpg   = instruction[ 30:26] ==  5'b11010;
assign op_cmpge  = instruction[ 30:26] ==  5'b11011;
assign op_cmpgeu = instruction[ 30:26] ==  5'b11100;
assign op_cmpgu  = instruction[ 30:26] ==  5'b11101;
assign op_cmpne  = instruction[ 30:26] ==  5'b11111;
assign op_lb     = instruction[ 31:26] ==  6'b000100;
assign op_lbu    = instruction[ 31:26] ==  6'b010000;
assign op_lh     = instruction[ 31:26] ==  6'b000111;
assign op_lhu    = instruction[ 31:26] ==  6'b001011;
assign op_lw     = instruction[ 31:26] ==  6'b001010;
assign op_mul    = instruction[ 30:26] ==  5'b00010;
assign op_nor    = instruction[ 30:26] ==  5'b00001;
assign op_or     = instruction[ 30:26] ==  5'b01110;
assign op_orhi   = instruction[ 31:26] ==  6'b011110;
assign op_raise  = instruction[ 31:26] ==  6'b101011;
assign op_rcsr   = instruction[ 31:26] ==  6'b100100;
assign op_sb     = instruction[ 31:26] ==  6'b001100;
assign op_sextb  = instruction[ 31:26] ==  6'b101100;
assign op_sexth  = instruction[ 31:26] ==  6'b110111;
assign op_sh     = instruction[ 31:26] ==  6'b000011;
assign op_sl     = instruction[ 30:26] ==  5'b01111;      
assign op_sr     = instruction[ 30:26] ==  5'b00101;
assign op_sru    = instruction[ 30:26] ==  5'b00000;
assign op_sub    = instruction[ 31:26] ==  6'b110010;
assign op_sw     = instruction[ 31:26] ==  6'b010110;
assign op_wcsr   = instruction[ 31:26] ==  6'b110100;
assign op_xnor   = instruction[ 30:26] ==  5'b01001;
assign op_xor    = instruction[ 30:26] ==  5'b00110;
assign arith = op_add | op_sub;
assign logical = op_and | op_andhi | op_nor | op_or | op_orhi | op_xor | op_xnor;
assign cmp = op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne;
assign bi_conditional = op_be | op_bg | op_bge | op_bgeu  | op_bgu | op_bne;
assign bi_unconditional = op_bi;
assign bra = op_b | bi_unconditional | bi_conditional;
assign call = op_call | op_calli;
assign shift = op_sl | op_sr | op_sru;
assign sext = op_sextb | op_sexth;
assign load = op_lb | op_lbu | op_lh | op_lhu | op_lw;
assign store = op_sb | op_sh | op_sw;
always @(*)
begin
    if (call) 
        d_result_sel_0 =  1'b1;
    else 
        d_result_sel_0 =  1'b0;
    if (call) 
        d_result_sel_1 =  2'b00;         
    else if ((instruction[31] == 1'b0) && !bra) 
        d_result_sel_1 =  2'b10;
    else
        d_result_sel_1 =  2'b01; 
    x_result_sel_csr =  1'b0;
    x_result_sel_sext =  1'b0;
    x_result_sel_logic =  1'b0;
    x_result_sel_add =  1'b0;
    if (op_rcsr)
        x_result_sel_csr =  1'b1;
    else if (sext)
        x_result_sel_sext =  1'b1;
    else if (logical) 
        x_result_sel_logic =  1'b1;
    else 
        x_result_sel_add =  1'b1;        
    m_result_sel_compare = cmp;
    m_result_sel_shift = shift;
    w_result_sel_load = load;
    w_result_sel_mul = op_mul; 
end
assign x_bypass_enable =  arith 
                        | logical
                        | sext 
                        | op_rcsr
                        ;
assign m_bypass_enable = x_bypass_enable 
                        | shift
                        | cmp
                        ;
assign read_enable_0 = ~(op_bi | op_calli);
assign read_idx_0 = instruction[25:21];
assign read_enable_1 = ~(op_bi | op_calli | load);
assign read_idx_1 = instruction[20:16];
assign write_enable = ~(bra | op_raise | store | op_wcsr);
assign write_idx = call
                    ? 5'd29
                    : instruction[31] == 1'b0 
                        ? instruction[20:16] 
                        : instruction[15:11];
assign size = instruction[27:26];
assign sign_extend = instruction[28];                      
assign adder_op = op_sub | op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne | bra;
assign logic_op = instruction[29:26];
assign direction = instruction[29];
assign branch = bra | call;
assign branch_reg = op_call | op_b;
assign condition = instruction[28:26];      
assign break_opcode = op_raise & ~instruction[2];
assign scall = op_raise & instruction[2];
assign eret = op_b & (instruction[25:21] == 5'd30);
assign bret = op_b & (instruction[25:21] == 5'd31);
assign csr_write_enable = op_wcsr;
assign sign_extend_immediate = ~(op_and | op_cmpgeu | op_cmpgu | op_nor | op_or | op_xnor | op_xor);
assign select_high_immediate = op_andhi | op_orhi;
assign select_call_immediate = instruction[31];
assign high_immediate = {instruction[15:0], 16'h0000};
assign extended_immediate = {{16{sign_extend_immediate & instruction[15]}}, instruction[15:0]};
assign call_immediate = {{6{instruction[25]}}, instruction[25:0]};
assign branch_immediate = {{16{instruction[15]}}, instruction[15:0]};
assign immediate = select_high_immediate ==  1'b1 
                        ? high_immediate 
                        : extended_immediate;
assign branch_offset = select_call_immediate ==  1'b1   
                        ? (call_immediate[ (clogb2(32'h7fffffff-32'h0)-2)-1:0])
                        : (branch_immediate[ (clogb2(32'h7fffffff-32'h0)-2)-1:0]);
endmodule 
module lm32_icache_medium_icache_debug ( 
    clk_i,
    rst_i,    
    stall_a,
    stall_f,
    address_a,
    address_f,
    read_enable_f,
    refill_ready,
    refill_data,
    iflush,
    valid_d,
    branch_predict_taken_d,
    stall_request,
    restart_request,
    refill_request,
    refill_address,
    refilling,
    inst
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = clogb2(bytes_per_line)-1-2;
localparam addr_set_width = clogb2(sets)-1;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
localparam addr_set_lsb = (addr_offset_msb+1);
localparam addr_set_msb = (addr_set_lsb+addr_set_width-1);
localparam addr_tag_lsb = (addr_set_msb+1);
localparam addr_tag_msb = clogb2( 32'h7fffffff- 32'h0)-1;
localparam addr_tag_width = (addr_tag_msb-addr_tag_lsb+1);
input clk_i;                                        
input rst_i;                                        
input stall_a;                                      
input stall_f;                                      
input valid_d;                                      
input branch_predict_taken_d;                       
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] address_a;                     
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] address_f;                     
input read_enable_f;                                
input refill_ready;                                 
input [ (32-1):0] refill_data;          
input iflush;                                       
output stall_request;                               
wire   stall_request;
output restart_request;                             
reg    restart_request;
output refill_request;                              
wire   refill_request;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] refill_address;               
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] refill_address;               
output refilling;                                   
reg    refilling;
output [ (32-1):0] inst;                
wire   [ (32-1):0] inst;
wire enable;
wire [0:associativity-1] way_mem_we;
wire [ (32-1):0] way_data[0:associativity-1];
wire [ ((addr_tag_width+1)-1):1] way_tag[0:associativity-1];
wire [0:associativity-1] way_valid;
wire [0:associativity-1] way_match;
wire miss;
wire [ (addr_set_width-1):0] tmem_read_address;
wire [ (addr_set_width-1):0] tmem_write_address;
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_read_address;
wire [ ((addr_offset_width+addr_set_width)-1):0] dmem_write_address;
wire [ ((addr_tag_width+1)-1):0] tmem_write_data;
reg [ 3:0] state;
wire flushing;
wire check;
wire refill;
reg [associativity-1:0] refill_way_select;
reg [ addr_offset_msb:addr_offset_lsb] refill_offset;
wire last_refill;
reg [ (addr_set_width-1):0] flush_set;
genvar i;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
   generate
      for (i = 0; i < associativity; i = i + 1)
	begin : memories
	   lm32_ram 
	     #(
	       .data_width                 (32),
	       .address_width              ( (addr_offset_width+addr_set_width))
) 
	   way_0_data_ram 
	     (
	      .read_clk                   (clk_i),
	      .write_clk                  (clk_i),
	      .reset                      (rst_i),
	      .read_address               (dmem_read_address),
	      .enable_read                (enable),
	      .write_address              (dmem_write_address),
	      .enable_write               ( 1'b1),
	      .write_enable               (way_mem_we[i]),
	      .write_data                 (refill_data),    
	      .read_data                  (way_data[i])
	      );
	   lm32_ram 
	     #(
	       .data_width                 ( (addr_tag_width+1)),
	       .address_width              ( addr_set_width)
	       ) 
	   way_0_tag_ram 
	     (
	      .read_clk                   (clk_i),
	      .write_clk                  (clk_i),
	      .reset                      (rst_i),
	      .read_address               (tmem_read_address),
	      .enable_read                (enable),
	      .write_address              (tmem_write_address),
	      .enable_write               ( 1'b1),
	      .write_enable               (way_mem_we[i] | flushing),
	      .write_data                 (tmem_write_data),
	      .read_data                  ({way_tag[i], way_valid[i]})
	      );
	end
endgenerate
generate
    for (i = 0; i < associativity; i = i + 1)
    begin : match
assign way_match[i] = ({way_tag[i], way_valid[i]} == {address_f[ addr_tag_msb:addr_tag_lsb],  1'b1});
    end
endgenerate
generate
    if (associativity == 1)
    begin : inst_1
assign inst = way_match[0] ? way_data[0] : 32'b0;
    end
    else if (associativity == 2)
	 begin : inst_2
assign inst = way_match[0] ? way_data[0] : (way_match[1] ? way_data[1] : 32'b0);
    end
endgenerate
generate 
    if (bytes_per_line > 4)
assign dmem_write_address = {refill_address[ addr_set_msb:addr_set_lsb], refill_offset};
    else
assign dmem_write_address = refill_address[ addr_set_msb:addr_set_lsb];
endgenerate
assign dmem_read_address = address_a[ addr_set_msb:addr_offset_lsb];
assign tmem_read_address = address_a[ addr_set_msb:addr_set_lsb];
assign tmem_write_address = flushing 
                                ? flush_set
                                : refill_address[ addr_set_msb:addr_set_lsb];
generate 
    if (bytes_per_line > 4)                            
assign last_refill = refill_offset == {addr_offset_width{1'b1}};
    else
assign last_refill =  1'b1;
endgenerate
assign enable = (stall_a ==  1'b0);
generate
    if (associativity == 1) 
    begin : we_1     
assign way_mem_we[0] = (refill_ready ==  1'b1);
    end
    else
    begin : we_2
assign way_mem_we[0] = (refill_ready ==  1'b1) && (refill_way_select[0] ==  1'b1);
assign way_mem_we[1] = (refill_ready ==  1'b1) && (refill_way_select[1] ==  1'b1);
    end
endgenerate                     
assign tmem_write_data[ 0] = last_refill & !flushing;
assign tmem_write_data[ ((addr_tag_width+1)-1):1] = refill_address[ addr_tag_msb:addr_tag_lsb];
assign flushing = |state[1:0];
assign check = state[2];
assign refill = state[3];
assign miss = (~(|way_match)) && (read_enable_f ==  1'b1) && (stall_f ==  1'b0) && !(valid_d && branch_predict_taken_d);
assign stall_request = (check ==  1'b0);
assign refill_request = (refill ==  1'b1);
generate
    if (associativity >= 2) 
    begin : way_select      
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_way_select <= {{associativity-1{1'b0}}, 1'b1};
    else
    begin        
        if (miss ==  1'b1)
            refill_way_select <= {refill_way_select[0], refill_way_select[1]};
    end
end
    end
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refilling <=  1'b0;
    else
        refilling <= refill;
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        state <=  4'b0001;
        flush_set <= { addr_set_width{1'b1}};
        refill_address <= { (clogb2(32'h7fffffff-32'h0)-2){1'bx}};
        restart_request <=  1'b0;
    end
    else 
    begin
        case (state)
         4'b0001:
        begin            
            if (flush_set == { addr_set_width{1'b0}})
                state <=  4'b0100;
            flush_set <= flush_set - 1'b1;
        end
         4'b0010:
        begin            
            if (flush_set == { addr_set_width{1'b0}})
		state <=  4'b0100;
            flush_set <= flush_set - 1'b1;
        end
         4'b0100:
        begin            
            if (stall_a ==  1'b0)
                restart_request <=  1'b0;
            if (iflush ==  1'b1)
            begin
                refill_address <= address_f;
                state <=  4'b0010;
            end
            else if (miss ==  1'b1)
            begin
                refill_address <= address_f;
                state <=  4'b1000;
            end
        end
         4'b1000:
        begin            
            if (refill_ready ==  1'b1)
            begin
                if (last_refill ==  1'b1)
                begin
                    restart_request <=  1'b1;
                    state <=  4'b0100;
                end
            end
        end
        endcase        
    end
end
generate 
    if (bytes_per_line > 4)
    begin
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        refill_offset <= {addr_offset_width{1'b0}};
    else 
    begin
        case (state)
         4'b0100:
        begin            
            if (iflush ==  1'b1)
                refill_offset <= {addr_offset_width{1'b0}};
            else if (miss ==  1'b1)
                refill_offset <= {addr_offset_width{1'b0}};
        end
         4'b1000:
        begin            
            if (refill_ready ==  1'b1)
                refill_offset <= refill_offset + 1'b1;
        end
        endcase        
    end
end
    end
endgenerate
endmodule
module lm32_debug_medium_icache_debug (
    clk_i, 
    rst_i,
    pc_x,
    load_x,
    store_x,
    load_store_address_x,
    csr_write_enable_x,
    csr_write_data,
    csr_x,
    jtag_csr_write_enable,
    jtag_csr_write_data,
    jtag_csr,
    eret_q_x,
    bret_q_x,
    stall_x,
    exception_x,
    q_x,
    dc_ss,
    dc_re,
    bp_match,
    wp_match
    );
parameter breakpoints = 0;                      
parameter watchpoints = 0;                      
input clk_i;                                    
input rst_i;                                    
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;                      
input load_x;                                   
input store_x;                                  
input [ (32-1):0] load_store_address_x;    
input csr_write_enable_x;                       
input [ (32-1):0] csr_write_data;          
input [ (5-1):0] csr_x;                    
input jtag_csr_write_enable;                    
input [ (32-1):0] jtag_csr_write_data;     
input [ (5-1):0] jtag_csr;                 
input eret_q_x;                                 
input bret_q_x;                                 
input stall_x;                                  
input exception_x;                              
input q_x;                                      
output dc_ss;                                   
reg    dc_ss;
output dc_re;                                   
reg    dc_re;
output bp_match;                                
wire   bp_match;        
output wp_match;                                
wire   wp_match;
genvar i;                                       
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] bp_a[0:breakpoints-1];       
reg bp_e[0:breakpoints-1];                      
wire [0:breakpoints-1]bp_match_n;               
reg [ 1:0] wpc_c[0:watchpoints-1];   
reg [ (32-1):0] wp[0:watchpoints-1];       
wire [0:watchpoints-1]wp_match_n;               
wire debug_csr_write_enable;                    
wire [ (32-1):0] debug_csr_write_data;     
wire [ (5-1):0] debug_csr;                 
reg [ 2:0] state;           
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
generate
    for (i = 0; i < breakpoints; i = i + 1)
    begin : bp_comb
assign bp_match_n[i] = ((bp_a[i] == pc_x) && (bp_e[i] ==  1'b1));
    end
endgenerate
generate 
    if (breakpoints > 0) 
assign bp_match = (|bp_match_n) || (state ==  3'b011);
    else
assign bp_match = state ==  3'b011;
endgenerate    
generate 
    for (i = 0; i < watchpoints; i = i + 1)
    begin : wp_comb
assign wp_match_n[i] = (wp[i] == load_store_address_x) && ((load_x & wpc_c[i][0]) | (store_x & wpc_c[i][1]));
    end               
endgenerate
generate
    if (watchpoints > 0) 
assign wp_match = |wp_match_n;                
    else
assign wp_match =  1'b0;
endgenerate
assign debug_csr_write_enable = (csr_write_enable_x ==  1'b1) || (jtag_csr_write_enable ==  1'b1);
assign debug_csr_write_data = jtag_csr_write_enable ==  1'b1 ? jtag_csr_write_data : csr_write_data;
assign debug_csr = jtag_csr_write_enable ==  1'b1 ? jtag_csr : csr_x;
generate
    for (i = 0; i < breakpoints; i = i + 1)
    begin : bp_seq
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        bp_a[i] <= { (clogb2(32'h7fffffff-32'h0)-2){1'bx}};
        bp_e[i] <=  1'b0;
    end
    else
    begin
        if ((debug_csr_write_enable ==  1'b1) && (debug_csr ==  5'h10 + i))
        begin
            bp_a[i] <= debug_csr_write_data[ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2];
            bp_e[i] <= debug_csr_write_data[0];
        end
    end
end    
    end
endgenerate
generate
    for (i = 0; i < watchpoints; i = i + 1)
    begin : wp_seq
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        wp[i] <= { 32{1'bx}};
        wpc_c[i] <=  2'b00;
    end
    else
    begin
        if (debug_csr_write_enable ==  1'b1)
        begin
            if (debug_csr ==  5'h8)
                wpc_c[i] <= debug_csr_write_data[3+i*2:2+i*2];
            if (debug_csr ==  5'h18 + i)
                wp[i] <= debug_csr_write_data;
        end
    end  
end
    end
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        dc_re <=  1'b0;
    else
    begin
        if ((debug_csr_write_enable ==  1'b1) && (debug_csr ==  5'h8))
            dc_re <= debug_csr_write_data[1];
    end
end    
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        state <=  3'b000;
        dc_ss <=  1'b0;
    end
    else
    begin
        if ((debug_csr_write_enable ==  1'b1) && (debug_csr ==  5'h8))
        begin
            dc_ss <= debug_csr_write_data[0];
            if (debug_csr_write_data[0] ==  1'b0) 
                state <=  3'b000;
            else 
                state <=  3'b001;
        end
        case (state)
         3'b001:
        begin
            if (   (   (eret_q_x ==  1'b1)
                    || (bret_q_x ==  1'b1)
                    )
                && (stall_x ==  1'b0)
               )
                state <=  3'b010; 
        end
         3'b010:
        begin
            if ((q_x ==  1'b1) && (stall_x ==  1'b0))
                state <=  3'b011;
        end
         3'b011:
        begin
                 if ((exception_x ==  1'b1) && (q_x ==  1'b1) && (stall_x ==  1'b0))
            begin
                dc_ss <=  1'b0;
                state <=  3'b100;
            end
        end
         3'b100:
        begin
                state <=  3'b000;
        end
        endcase
    end
end
endmodule
module lm32_instruction_unit_medium_icache_debug (
    clk_i,
    rst_i,
    stall_a,
    stall_f,
    stall_d,
    stall_x,
    stall_m,
    valid_f,
    valid_d,
    kill_f,
    branch_predict_taken_d,
    branch_predict_address_d,
    exception_m,
    branch_taken_m,
    branch_mispredict_taken_m,
    branch_target_m,
    iflush,
    i_dat_i,
    i_ack_i,
    i_err_i,
    i_rty_i,
    jtag_read_enable,
    jtag_write_enable,
    jtag_write_data,
    jtag_address,
    pc_f,
    pc_d,
    pc_x,
    pc_m,
    pc_w,
    icache_stall_request,
    icache_restart_request,
    icache_refill_request,
    icache_refilling,
    i_dat_o,
    i_adr_o,
    i_cyc_o,
    i_sel_o,
    i_stb_o,
    i_we_o,
    i_cti_o,
    i_lock_o,
    i_bte_o,
    jtag_read_data,
    jtag_access_complete,
    instruction_f,
    instruction_d
    );
parameter eba_reset =  32'h00000000;                   
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam eba_reset_minus_4 = eba_reset - 4;
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_f;                                          
input stall_d;                                          
input stall_x;                                          
input stall_m;                                          
input valid_f;                                          
input valid_d;                                          
input kill_f;                                           
input branch_predict_taken_d;                           
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_predict_address_d;          
input exception_m;
input branch_taken_m;                                   
input branch_mispredict_taken_m;                        
input [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] branch_target_m;                   
input iflush;                                           
input [ (32-1):0] i_dat_i;                         
input i_ack_i;                                          
input i_err_i;                                          
input i_rty_i;                                          
input jtag_read_enable;                                 
input jtag_write_enable;                                
input [ 7:0] jtag_write_data;                 
input [ (32-1):0] jtag_address;                    
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_f;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_d;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_x;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_m;
output [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;                             
reg    [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_w;
output icache_stall_request;                            
wire   icache_stall_request;
output icache_restart_request;                          
wire   icache_restart_request;
output icache_refill_request;                           
wire   icache_refill_request;
output icache_refilling;                                
wire   icache_refilling;
output [ (32-1):0] i_dat_o;                        
reg    [ (32-1):0] i_dat_o;
output [ (32-1):0] i_adr_o;                        
reg    [ (32-1):0] i_adr_o;
output i_cyc_o;                                         
reg    i_cyc_o; 
output [ (4-1):0] i_sel_o;                 
reg    [ (4-1):0] i_sel_o;
output i_stb_o;                                         
reg    i_stb_o;
output i_we_o;                                          
reg    i_we_o;
output [ (3-1):0] i_cti_o;                       
reg    [ (3-1):0] i_cti_o;
output i_lock_o;                                        
reg    i_lock_o;
output [ (2-1):0] i_bte_o;                       
wire   [ (2-1):0] i_bte_o;
output [ 7:0] jtag_read_data;                 
reg    [ 7:0] jtag_read_data;
output jtag_access_complete;                            
wire   jtag_access_complete;
output [ (32-1):0] instruction_f;           
wire   [ (32-1):0] instruction_f;
output [ (32-1):0] instruction_d;           
reg    [ (32-1):0] instruction_d;
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] pc_a;                                
reg [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] restart_address;                     
wire icache_read_enable_f;                              
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] icache_refill_address;              
reg icache_refill_ready;                                
reg [ (32-1):0] icache_refill_data;         
wire [ (32-1):0] icache_data_f;             
wire [ (3-1):0] first_cycle_type;                
wire [ (3-1):0] next_cycle_type;                 
wire last_word;                                         
wire [ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2] first_address;                      
reg jtag_access;                                        
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_icache_medium_icache_debug #(
    .associativity          (associativity),
    .sets                   (sets),
    .bytes_per_line         (bytes_per_line),
    .base_address           (base_address),
    .limit                  (limit)
    ) icache ( 
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),      
    .stall_a                (stall_a),
    .stall_f                (stall_f),
    .branch_predict_taken_d (branch_predict_taken_d),
    .valid_d                (valid_d),
    .address_a              (pc_a),
    .address_f              (pc_f),
    .read_enable_f          (icache_read_enable_f),
    .refill_ready           (icache_refill_ready),
    .refill_data            (icache_refill_data),
    .iflush                 (iflush),
    .stall_request          (icache_stall_request),
    .restart_request        (icache_restart_request),
    .refill_request         (icache_refill_request),
    .refill_address         (icache_refill_address),
    .refilling              (icache_refilling),
    .inst                   (icache_data_f)
    );
assign icache_read_enable_f =    (valid_f ==  1'b1)
                              && (kill_f ==  1'b0)
                              ;
always @(*)
begin
      if (branch_taken_m ==  1'b1)
	if ((branch_mispredict_taken_m ==  1'b1) && (exception_m ==  1'b0))
	  pc_a = pc_x;
	else
          pc_a = branch_target_m;
      else
	if ( (valid_d ==  1'b1) && (branch_predict_taken_d ==  1'b1) )
	  pc_a = branch_predict_address_d;
	else
          if (icache_restart_request ==  1'b1)
            pc_a = restart_address;
	  else 
            pc_a = pc_f + 1'b1;
end
assign instruction_f = icache_data_f;
assign i_bte_o =  2'b00;
generate
    case (bytes_per_line)
    4:
    begin
assign first_cycle_type =  3'b111;
assign next_cycle_type =  3'b111;
assign last_word =  1'b1;
assign first_address = icache_refill_address;
    end
    8:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type =  3'b111;
assign last_word = i_adr_o[addr_offset_msb:addr_offset_lsb] == 1'b1;
assign first_address = {icache_refill_address[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:addr_offset_msb+1], {addr_offset_width{1'b0}}};
    end
    16:
    begin
assign first_cycle_type =  3'b010;
assign next_cycle_type = i_adr_o[addr_offset_msb] == 1'b1 ?  3'b111 :  3'b010;
assign last_word = i_adr_o[addr_offset_msb:addr_offset_lsb] == 2'b11;
assign first_address = {icache_refill_address[ (clogb2(32'h7fffffff-32'h0)-2)+2-1:addr_offset_msb+1], {addr_offset_width{1'b0}}};
    end
    endcase
endgenerate
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        pc_f <= eba_reset_minus_4[ ((clogb2(32'h7fffffff-32'h0)-2)+2-1):2];
        pc_d <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_x <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_m <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
        pc_w <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
    end
    else
    begin
        if (stall_f ==  1'b0)
            pc_f <= pc_a;
        if (stall_d ==  1'b0)
            pc_d <= pc_f;
        if (stall_x ==  1'b0)
            pc_x <= pc_d;
        if (stall_m ==  1'b0)
            pc_m <= pc_x;
        pc_w <= pc_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        restart_address <= { (clogb2(32'h7fffffff-32'h0)-2){1'b0}};
    else
    begin
            if (icache_refill_request ==  1'b1)
                restart_address <= icache_refill_address;
    end
end
assign jtag_access_complete = (i_cyc_o ==  1'b1) && ((i_ack_i ==  1'b1) || (i_err_i ==  1'b1)) && (jtag_access ==  1'b1);
always @(*)
begin
    case (jtag_address[1:0])
    2'b00: jtag_read_data = i_dat_i[ 31:24];
    2'b01: jtag_read_data = i_dat_i[ 23:16];
    2'b10: jtag_read_data = i_dat_i[ 15:8];
    2'b11: jtag_read_data = i_dat_i[ 7:0];
    endcase 
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        i_cyc_o <=  1'b0;
        i_stb_o <=  1'b0;
        i_adr_o <= { 32{1'b0}};
        i_cti_o <=  3'b111;
        i_lock_o <=  1'b0;
        icache_refill_data <= { 32{1'b0}};
        icache_refill_ready <=  1'b0;
        i_we_o <=  1'b0;
        i_sel_o <= 4'b1111;
        jtag_access <=  1'b0;
    end
    else
    begin   
        icache_refill_ready <=  1'b0;
        if (i_cyc_o ==  1'b1)
        begin
            if ((i_ack_i ==  1'b1) || (i_err_i ==  1'b1))
            begin
                if (jtag_access ==  1'b1)
                begin
                    i_cyc_o <=  1'b0;
                    i_stb_o <=  1'b0;       
                    i_we_o <=  1'b0;  
                    jtag_access <=  1'b0;    
                end
                else
                begin
                    if (last_word ==  1'b1)
                    begin
                        i_cyc_o <=  1'b0;
                        i_stb_o <=  1'b0;
                        i_lock_o <=  1'b0;
                    end
                    i_adr_o[addr_offset_msb:addr_offset_lsb] <= i_adr_o[addr_offset_msb:addr_offset_lsb] + 1'b1;
                    i_cti_o <= next_cycle_type;
                    icache_refill_ready <=  1'b1;
                    icache_refill_data <= i_dat_i;
                end
            end
        end
        else
        begin
            if ((icache_refill_request ==  1'b1) && (icache_refill_ready ==  1'b0))
            begin
                i_sel_o <= 4'b1111;
                i_adr_o <= {first_address, 2'b00};
                i_cyc_o <=  1'b1;
                i_stb_o <=  1'b1;                
                i_cti_o <= first_cycle_type;
            end
            else
            begin
                if ((jtag_read_enable ==  1'b1) || (jtag_write_enable ==  1'b1))
                begin
                    case (jtag_address[1:0])
                    2'b00: i_sel_o <= 4'b1000;
                    2'b01: i_sel_o <= 4'b0100;
                    2'b10: i_sel_o <= 4'b0010;
                    2'b11: i_sel_o <= 4'b0001;
                    endcase
                    i_adr_o <= jtag_address;
                    i_dat_o <= {4{jtag_write_data}};
                    i_cyc_o <=  1'b1;
                    i_stb_o <=  1'b1;
                    i_we_o <= jtag_write_enable;
                    i_cti_o <=  3'b111;
                    jtag_access <=  1'b1;
                end
            end 
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        instruction_d <= { 32{1'b0}};
    end
    else
    begin
        if (stall_d ==  1'b0)
        begin
            instruction_d <= instruction_f;
        end
    end
end  
endmodule
module lm32_jtag_medium_icache_debug (
    clk_i,
    rst_i,
    jtag_clk, 
    jtag_update,
    jtag_reg_q,
    jtag_reg_addr_q,
    csr,
    csr_write_enable,
    csr_write_data,
    stall_x,
    jtag_read_data,
    jtag_access_complete,
    exception_q_w,
    jtx_csr_read_data,
    jrx_csr_read_data,
    jtag_csr_write_enable,
    jtag_csr_write_data,
    jtag_csr,
    jtag_read_enable,
    jtag_write_enable,
    jtag_write_data,
    jtag_address,
    jtag_break,
    jtag_reset,
    jtag_reg_d,
    jtag_reg_addr_d
    );
input clk_i;                                            
input rst_i;                                            
input jtag_clk;                                         
input jtag_update;                                      
input [ 7:0] jtag_reg_q;                      
input [2:0] jtag_reg_addr_q;                            
input [ (5-1):0] csr;                              
input csr_write_enable;                                 
input [ (32-1):0] csr_write_data;                  
input stall_x;                                          
input [ 7:0] jtag_read_data;                  
input jtag_access_complete;                             
input exception_q_w;                                    
output [ (32-1):0] jtx_csr_read_data;              
wire   [ (32-1):0] jtx_csr_read_data;
output [ (32-1):0] jrx_csr_read_data;              
wire   [ (32-1):0] jrx_csr_read_data;
output jtag_csr_write_enable;                           
reg    jtag_csr_write_enable;
output [ (32-1):0] jtag_csr_write_data;            
wire   [ (32-1):0] jtag_csr_write_data;
output [ (5-1):0] jtag_csr;                        
wire   [ (5-1):0] jtag_csr;
output jtag_read_enable;                                
reg    jtag_read_enable;
output jtag_write_enable;                               
reg    jtag_write_enable;
output [ 7:0] jtag_write_data;                
wire   [ 7:0] jtag_write_data;        
output [ (32-1):0] jtag_address;                   
wire   [ (32-1):0] jtag_address;
output jtag_break;                                      
reg    jtag_break;
output jtag_reset;                                      
reg    jtag_reset;
output [ 7:0] jtag_reg_d;
reg    [ 7:0] jtag_reg_d;
output [2:0] jtag_reg_addr_d;
wire   [2:0] jtag_reg_addr_d;
reg rx_update;                          
reg rx_update_r;                        
reg rx_update_r_r;                      
reg rx_update_r_r_r;                    
wire [ 7:0] rx_byte;   
wire [2:0] rx_addr;
reg [ 7:0] uart_tx_byte;      
reg uart_tx_valid;                      
reg [ 7:0] uart_rx_byte;      
reg uart_rx_valid;                      
reg [ 3:0] command;             
reg [ 7:0] jtag_byte_0;       
reg [ 7:0] jtag_byte_1;
reg [ 7:0] jtag_byte_2;
reg [ 7:0] jtag_byte_3;
reg [ 7:0] jtag_byte_4;
reg processing;                         
reg [ 3:0] state;       
assign jtag_csr_write_data = {jtag_byte_0, jtag_byte_1, jtag_byte_2, jtag_byte_3};
assign jtag_csr = jtag_byte_4[ (5-1):0];
assign jtag_address = {jtag_byte_0, jtag_byte_1, jtag_byte_2, jtag_byte_3};
assign jtag_write_data = jtag_byte_4;
assign jtag_reg_addr_d[1:0] = {uart_rx_valid, uart_tx_valid};         
assign jtag_reg_addr_d[2] = processing;
assign jtx_csr_read_data = {{ 32-9{1'b0}}, uart_tx_valid, 8'h00};
assign jrx_csr_read_data = {{ 32-9{1'b0}}, uart_rx_valid, uart_rx_byte};
assign rx_byte = jtag_reg_q;
assign rx_addr = jtag_reg_addr_q;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        rx_update <= 1'b0;
        rx_update_r <= 1'b0;
        rx_update_r_r <= 1'b0;
        rx_update_r_r_r <= 1'b0;
    end
    else
    begin
        rx_update <= jtag_update;
        rx_update_r <= rx_update;
        rx_update_r_r <= rx_update_r;
        rx_update_r_r_r <= rx_update_r_r;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        state <=  4'h0;
        command <= 4'b0000;
        jtag_reg_d <= 8'h00;
        processing <=  1'b0;
        jtag_csr_write_enable <=  1'b0;
        jtag_read_enable <=  1'b0;
        jtag_write_enable <=  1'b0;
        jtag_break <=  1'b0;
        jtag_reset <=  1'b0;
        uart_tx_byte <= 8'h00;
        uart_tx_valid <=  1'b0;
        uart_rx_byte <= 8'h00;
        uart_rx_valid <=  1'b0;
    end
    else
    begin
        if ((csr_write_enable ==  1'b1) && (stall_x ==  1'b0))
        begin
            case (csr)
             5'he:
            begin
                uart_tx_byte <= csr_write_data[ 7:0];
                uart_tx_valid <=  1'b1;
            end
             5'hf:
            begin
                uart_rx_valid <=  1'b0;
            end
            endcase
        end
        if (exception_q_w ==  1'b1)
        begin
            jtag_break <=  1'b0;
            jtag_reset <=  1'b0;
        end
        case (state)
         4'h0:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                command <= rx_byte[7:4];                
                case (rx_addr)
                 3'b000:
                begin
                    case (rx_byte[7:4])
                     4'b0001:
                        state <=  4'h1;
                     4'b0011:
                    begin
                        {jtag_byte_2, jtag_byte_3} <= {jtag_byte_2, jtag_byte_3} + 1'b1;
                        state <=  4'h6;
                    end
                     4'b0010:
                        state <=  4'h1;
                     4'b0100:
                    begin
                        {jtag_byte_2, jtag_byte_3} <= {jtag_byte_2, jtag_byte_3} + 1'b1;
                        state <= 5;
                    end
                     4'b0101:
                        state <=  4'h1;
                     4'b0110:
                    begin
                        uart_rx_valid <=  1'b0;    
                        uart_tx_valid <=  1'b0;         
                        jtag_break <=  1'b1;
                    end
                     4'b0111:
                    begin
                        uart_rx_valid <=  1'b0;    
                        uart_tx_valid <=  1'b0;         
                        jtag_reset <=  1'b1;
                    end
                    endcase                               
                end
                 3'b001:
                begin
                    uart_rx_byte <= rx_byte;
                    uart_rx_valid <=  1'b1;
                end                    
                 3'b010:
                begin
                    jtag_reg_d <= uart_tx_byte;
                    uart_tx_valid <=  1'b0;
                end
                default:
                    ;
                endcase                
            end
        end
         4'h1:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_0 <= rx_byte;
                state <=  4'h2;
            end
        end
         4'h2:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_1 <= rx_byte;
                state <=  4'h3;
            end
        end
         4'h3:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_2 <= rx_byte;
                state <=  4'h4;
            end
        end
         4'h4:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_3 <= rx_byte;
                if (command ==  4'b0001)
                    state <=  4'h6;
                else 
                    state <=  4'h5;
            end
        end
         4'h5:
        begin
            if ((~rx_update_r_r_r & rx_update_r_r) ==  1'b1)
            begin
                jtag_byte_4 <= rx_byte;
                state <=  4'h6;
            end
        end
         4'h6:
        begin
            case (command)
             4'b0001,
             4'b0011:
            begin
                jtag_read_enable <=  1'b1;
                processing <=  1'b1;
                state <=  4'h7;
            end
             4'b0010,
             4'b0100:
            begin
                jtag_write_enable <=  1'b1;
                processing <=  1'b1;
                state <=  4'h7;
            end
             4'b0101:
            begin
                jtag_csr_write_enable <=  1'b1;
                processing <=  1'b1;
                state <=  4'h8;
            end
            endcase
        end
         4'h7:
        begin
            if (jtag_access_complete ==  1'b1)
            begin          
                jtag_read_enable <=  1'b0;
                jtag_reg_d <= jtag_read_data;
                jtag_write_enable <=  1'b0;  
                processing <=  1'b0;
                state <=  4'h0;
            end
        end    
         4'h8:
        begin
            jtag_csr_write_enable <=  1'b0;
            processing <=  1'b0;
            state <=  4'h0;
        end    
        endcase
    end
end
endmodule
module lm32_interrupt_medium_icache_debug (
    clk_i, 
    rst_i,
    interrupt,
    stall_x,
    non_debug_exception,
    debug_exception,
    eret_q_x,
    bret_q_x,
    csr,
    csr_write_data,
    csr_write_enable,
    interrupt_exception,
    csr_read_data
    );
parameter interrupts =  32;         
input clk_i;                                    
input rst_i;                                    
input [interrupts-1:0] interrupt;               
input stall_x;                                  
input non_debug_exception;                      
input debug_exception;                          
input eret_q_x;                                 
input bret_q_x;                                 
input [ (5-1):0] csr;                      
input [ (32-1):0] csr_write_data;          
input csr_write_enable;                         
output interrupt_exception;                     
wire   interrupt_exception;
output [ (32-1):0] csr_read_data;          
reg    [ (32-1):0] csr_read_data;
wire [interrupts-1:0] asserted;                 
wire [interrupts-1:0] interrupt_n_exception;
reg ie;                                         
reg eie;                                        
reg bie;                                        
reg [interrupts-1:0] ip;                        
reg [interrupts-1:0] im;                        
assign interrupt_n_exception = ip & im;
assign interrupt_exception = (|interrupt_n_exception) & ie;
assign asserted = ip | interrupt;
generate
    if (interrupts > 1) 
    begin
always @(*)
begin
    case (csr)
     5'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    bie,
                                    eie, 
                                    ie
                                   };
     5'h2:  csr_read_data = ip;
     5'h1:  csr_read_data = im;
    default:       csr_read_data = { 32{1'bx}};
    endcase
end
    end
    else
    begin
always @(*)
begin
    case (csr)
     5'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    bie, 
                                    eie, 
                                    ie
                                   };
     5'h2:  csr_read_data = ip;
    default:       csr_read_data = { 32{1'bx}};
      endcase
end
    end
endgenerate
   reg [ 10:0] eie_delay  = 0;
generate
    if (interrupts > 1)
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie                   <=  1'b0;
        eie                  <=  1'b0;
        bie                  <=  1'b0;
        im                   <= {interrupts{1'b0}};
        ip                   <= {interrupts{1'b0}};
       eie_delay             <= 0;
    end
    else
    begin
        ip                   <= asserted;
        if (non_debug_exception ==  1'b1)
        begin
            eie              <= ie;
            ie               <=  1'b0;
        end
        else if (debug_exception ==  1'b1)
        begin
            bie              <= ie;
            ie               <=  1'b0;
        end
        else if (stall_x ==  1'b0)
        begin
           if(eie_delay[0])
             ie              <= eie;
           eie_delay         <= {1'b0, eie_delay[ 10:1]};
            if (eret_q_x ==  1'b1) begin
               eie_delay[ 10] <=  1'b1;
               eie_delay[ 10-1:0] <= 0;
            end
            else if (bret_q_x ==  1'b1)
                ie      <= bie;
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  5'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                    bie <= csr_write_data[2];
                end
                if (csr ==  5'h1)
                    im  <= csr_write_data[interrupts-1:0];
                if (csr ==  5'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
else
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie              <=  1'b0;
        eie             <=  1'b0;
        bie             <=  1'b0;
        ip              <= {interrupts{1'b0}};
       eie_delay        <= 0;
    end
    else
    begin
        ip              <= asserted;
        if (non_debug_exception ==  1'b1)
        begin
            eie         <= ie;
            ie          <=  1'b0;
        end
        else if (debug_exception ==  1'b1)
        begin
            bie         <= ie;
            ie          <=  1'b0;
        end
        else if (stall_x ==  1'b0)
          begin
             if(eie_delay[0])
               ie              <= eie;
             eie_delay         <= {1'b0, eie_delay[ 10:1]};
             if (eret_q_x ==  1'b1) begin
                eie_delay[ 10] <=  1'b1;
                eie_delay[ 10-1:0] <= 0;
             end
            else if (bret_q_x ==  1'b1)
                ie      <= bie;
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  5'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                    bie <= csr_write_data[2];
                end
                if (csr ==  5'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
endgenerate
endmodule
module lm32_top_minimal (
    clk_i,
    rst_i,
    interrupt,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset = 32'h00000000;
parameter sdb_address = 32'h00000000;
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_cpu_minimal 
	#(
		.eba_reset(eba_reset),
    .sdb_address(sdb_address)
	) cpu (
    .clk_i                 (clk_i),
    .rst_i                 (rst_i),
    .interrupt             (interrupt),
    .I_DAT_I               (I_DAT_I),
    .I_ACK_I               (I_ACK_I),
    .I_ERR_I               (I_ERR_I),
    .I_RTY_I               (I_RTY_I),
    .D_DAT_I               (D_DAT_I),
    .D_ACK_I               (D_ACK_I),
    .D_ERR_I               (D_ERR_I),
    .D_RTY_I               (D_RTY_I),
    .I_DAT_O               (I_DAT_O),
    .I_ADR_O               (I_ADR_O),
    .I_CYC_O               (I_CYC_O),
    .I_SEL_O               (I_SEL_O),
    .I_STB_O               (I_STB_O),
    .I_WE_O                (I_WE_O),
    .I_CTI_O               (I_CTI_O),
    .I_LOCK_O              (I_LOCK_O),
    .I_BTE_O               (I_BTE_O),
    .D_DAT_O               (D_DAT_O),
    .D_ADR_O               (D_ADR_O),
    .D_CYC_O               (D_CYC_O),
    .D_SEL_O               (D_SEL_O),
    .D_STB_O               (D_STB_O),
    .D_WE_O                (D_WE_O),
    .D_CTI_O               (D_CTI_O),
    .D_LOCK_O              (D_LOCK_O),
    .D_BTE_O               (D_BTE_O)
    );
endmodule
module lm32_mc_arithmetic_minimal (
    clk_i,
    rst_i,
    stall_d,
    kill_x,
    operand_0_d,
    operand_1_d,
    result_x,
    stall_request_x
    );
input clk_i;                                    
input rst_i;                                    
input stall_d;                                  
input kill_x;                                   
input [ (32-1):0] operand_0_d;
input [ (32-1):0] operand_1_d;
output [ (32-1):0] result_x;               
reg    [ (32-1):0] result_x;
output stall_request_x;                         
wire   stall_request_x;
reg [ (32-1):0] p;                         
reg [ (32-1):0] a;
reg [ (32-1):0] b;
reg [ 2:0] state;                 
reg [5:0] cycles;                               
assign stall_request_x = state !=  3'b000;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        cycles <= {6{1'b0}};
        p <= { 32{1'b0}};
        a <= { 32{1'b0}};
        b <= { 32{1'b0}};
        result_x <= { 32{1'b0}};
        state <=  3'b000;
    end
    else
    begin
        case (state)
         3'b000:
        begin
            if (stall_d ==  1'b0)                 
            begin          
                cycles <=  32;
                p <= 32'b0;
                a <= operand_0_d;
                b <= operand_1_d;                    
            end            
        end
        endcase
    end
end 
endmodule
module lm32_cpu_minimal (
    clk_i,
    rst_i,
    interrupt,
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );
parameter eba_reset =  32'h00000000;                           
parameter sdb_address =   32'h00000000;
parameter icache_associativity = 1;    
parameter icache_sets = 512;                      
parameter icache_bytes_per_line = 16;  
parameter icache_base_address = 0;      
parameter icache_limit = 0;                    
parameter dcache_associativity = 1;    
parameter dcache_sets = 512;                      
parameter dcache_bytes_per_line = 16;  
parameter dcache_base_address = 0;      
parameter dcache_limit = 0;                    
parameter watchpoints = 0;
parameter breakpoints = 0;
parameter interrupts =  32;                         
input clk_i;                                    
input rst_i;                                    
input [ (32-1):0] interrupt;          
input [ (32-1):0] I_DAT_I;                 
input I_ACK_I;                                  
input I_ERR_I;                                  
input I_RTY_I;                                  
input [ (32-1):0] D_DAT_I;                 
input D_ACK_I;                                  
input D_ERR_I;                                  
input D_RTY_I;                                  
output [ (32-1):0] I_DAT_O;                
wire   [ (32-1):0] I_DAT_O;
output [ (32-1):0] I_ADR_O;                
wire   [ (32-1):0] I_ADR_O;
output I_CYC_O;                                 
wire   I_CYC_O;
output [ (4-1):0] I_SEL_O;         
wire   [ (4-1):0] I_SEL_O;
output I_STB_O;                                 
wire   I_STB_O;
output I_WE_O;                                  
wire   I_WE_O;
output [ (3-1):0] I_CTI_O;               
wire   [ (3-1):0] I_CTI_O;
output I_LOCK_O;                                
wire   I_LOCK_O;
output [ (2-1):0] I_BTE_O;               
wire   [ (2-1):0] I_BTE_O;
output [ (32-1):0] D_DAT_O;                
wire   [ (32-1):0] D_DAT_O;
output [ (32-1):0] D_ADR_O;                
wire   [ (32-1):0] D_ADR_O;
output D_CYC_O;                                 
wire   D_CYC_O;
output [ (4-1):0] D_SEL_O;         
wire   [ (4-1):0] D_SEL_O;
output D_STB_O;                                 
wire   D_STB_O;
output D_WE_O;                                  
wire   D_WE_O;
output [ (3-1):0] D_CTI_O;               
wire   [ (3-1):0] D_CTI_O;
output D_LOCK_O;                                
wire   D_LOCK_O;
output [ (2-1):0] D_BTE_O;               
wire   [ (2-1):0] D_BTE_O;
reg valid_f;                                    
reg valid_d;                                    
reg valid_x;                                    
reg valid_m;                                    
reg valid_w;                                    
wire q_x;
wire [ (32-1):0] immediate_d;              
wire load_d;                                    
reg load_x;                                     
reg load_m;
wire load_q_x;
wire store_q_x;
wire q_m;
wire load_q_m;
wire store_q_m;
wire store_d;                                   
reg store_x;
reg store_m;
wire [ 1:0] size_d;                   
reg [ 1:0] size_x;
wire branch_d;                                  
wire branch_predict_d;                          
wire branch_predict_taken_d;                    
wire [ ((32-2)+2-1):2] branch_predict_address_d;   
wire [ ((32-2)+2-1):2] branch_target_d;
wire bi_unconditional;
wire bi_conditional;
reg branch_x;                                   
reg branch_predict_x;
reg branch_predict_taken_x;
reg branch_m;
reg branch_predict_m;
reg branch_predict_taken_m;
wire branch_mispredict_taken_m;                 
wire branch_flushX_m;                           
wire branch_reg_d;                              
wire [ ((32-2)+2-1):2] branch_offset_d;            
reg [ ((32-2)+2-1):2] branch_target_x;             
reg [ ((32-2)+2-1):2] branch_target_m;
wire [ 0:0] d_result_sel_0_d; 
wire [ 1:0] d_result_sel_1_d; 
wire x_result_sel_csr_d;                        
reg x_result_sel_csr_x;
wire x_result_sel_shift_d;                      
reg x_result_sel_shift_x;
wire x_result_sel_logic_d;                      
wire x_result_sel_add_d;                        
reg x_result_sel_add_x;
wire m_result_sel_compare_d;                    
reg m_result_sel_compare_x;
reg m_result_sel_compare_m;
wire w_result_sel_load_d;                       
reg w_result_sel_load_x;
reg w_result_sel_load_m;
reg w_result_sel_load_w;
wire x_bypass_enable_d;                         
reg x_bypass_enable_x;                          
wire m_bypass_enable_d;                         
reg m_bypass_enable_x;                          
reg m_bypass_enable_m;
wire sign_extend_d;                             
reg sign_extend_x;
wire write_enable_d;                            
reg write_enable_x;
wire write_enable_q_x;
reg write_enable_m;
wire write_enable_q_m;
reg write_enable_w;
wire write_enable_q_w;
wire read_enable_0_d;                           
wire [ (5-1):0] read_idx_0_d;          
wire read_enable_1_d;                           
wire [ (5-1):0] read_idx_1_d;          
wire [ (5-1):0] write_idx_d;           
reg [ (5-1):0] write_idx_x;            
reg [ (5-1):0] write_idx_m;
reg [ (5-1):0] write_idx_w;
wire [ (4 -1):0] csr_d;                     
reg  [ (4 -1):0] csr_x;                  
wire [ (3-1):0] condition_d;         
reg [ (3-1):0] condition_x;          
wire scall_d;                                   
reg scall_x;    
wire eret_d;                                    
reg eret_x;
wire eret_q_x;
wire csr_write_enable_d;                        
reg csr_write_enable_x;
wire csr_write_enable_q_x;
reg [ (32-1):0] d_result_0;                
reg [ (32-1):0] d_result_1;                
reg [ (32-1):0] x_result;                  
reg [ (32-1):0] m_result;                  
reg [ (32-1):0] w_result;                  
reg [ (32-1):0] operand_0_x;               
reg [ (32-1):0] operand_1_x;               
reg [ (32-1):0] store_operand_x;           
reg [ (32-1):0] operand_m;                 
reg [ (32-1):0] operand_w;                 
reg [ (32-1):0] reg_data_live_0;          
reg [ (32-1):0] reg_data_live_1;  
reg use_buf;                                    
reg [ (32-1):0] reg_data_buf_0;
reg [ (32-1):0] reg_data_buf_1;
wire [ (32-1):0] reg_data_0;               
wire [ (32-1):0] reg_data_1;               
reg [ (32-1):0] bypass_data_0;             
reg [ (32-1):0] bypass_data_1;             
wire reg_write_enable_q_w;
reg interlock;                                  
wire stall_a;                                   
wire stall_f;                                   
wire stall_d;                                   
wire stall_x;                                   
wire stall_m;                                   
wire adder_op_d;                                
reg adder_op_x;                                 
reg adder_op_x_n;                               
wire [ (32-1):0] adder_result_x;           
wire adder_overflow_x;                          
wire adder_carry_n_x;                           
wire [ 3:0] logic_op_d;           
reg [ 3:0] logic_op_x;            
wire [ (32-1):0] logic_result_x;           
wire [ (32-1):0] shifter_result_x;         
wire [ (32-1):0] interrupt_csr_read_data_x;
wire [ (32-1):0] cfg;                      
wire [ (32-1):0] cfg2;                     
reg [ (32-1):0] csr_read_data_x;           
wire [ ((32-2)+2-1):2] pc_f;                       
wire [ ((32-2)+2-1):2] pc_d;                       
wire [ ((32-2)+2-1):2] pc_x;                       
wire [ ((32-2)+2-1):2] pc_m;                       
wire [ ((32-2)+2-1):2] pc_w;                       
wire [ (32-1):0] instruction_f;     
wire [ (32-1):0] instruction_d;     
wire [ (32-1):0] load_data_w;              
wire stall_wb_load;                             
wire raw_x_0;                                   
wire raw_x_1;                                   
wire raw_m_0;                                   
wire raw_m_1;                                   
wire raw_w_0;                                   
wire raw_w_1;                                   
wire cmp_zero;                                  
wire cmp_negative;                              
wire cmp_overflow;                              
wire cmp_carry_n;                               
reg condition_met_x;                            
reg condition_met_m;
wire branch_taken_m;                            
wire kill_f;                                    
wire kill_d;                                    
wire kill_x;                                    
wire kill_m;                                    
wire kill_w;                                    
reg [ (32-2)+2-1:8] eba;                 
reg [ (3-1):0] eid_x;                      
wire exception_x;                               
reg exception_m;
reg exception_w;
wire exception_q_w;
wire interrupt_exception;                       
wire system_call_exception;                     
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
lm32_instruction_unit_minimal #(
    .eba_reset              (eba_reset),
    .associativity          (icache_associativity),
    .sets                   (icache_sets),
    .bytes_per_line         (icache_bytes_per_line),
    .base_address           (icache_base_address),
    .limit                  (icache_limit)
  ) instruction_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_f                (stall_f),
    .stall_d                (stall_d),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .valid_f                (valid_f),
    .valid_d                (valid_d),
    .kill_f                 (kill_f),
    .branch_predict_taken_d (branch_predict_taken_d),
    .branch_predict_address_d (branch_predict_address_d),
    .exception_m            (exception_m),
    .branch_taken_m         (branch_taken_m),
    .branch_mispredict_taken_m (branch_mispredict_taken_m),
    .branch_target_m        (branch_target_m),
    .i_dat_i                (I_DAT_I),
    .i_ack_i                (I_ACK_I),
    .i_err_i                (I_ERR_I),
    .i_rty_i                (I_RTY_I),
    .pc_f                   (pc_f),
    .pc_d                   (pc_d),
    .pc_x                   (pc_x),
    .pc_m                   (pc_m),
    .pc_w                   (pc_w),
    .i_dat_o                (I_DAT_O),
    .i_adr_o                (I_ADR_O),
    .i_cyc_o                (I_CYC_O),
    .i_sel_o                (I_SEL_O),
    .i_stb_o                (I_STB_O),
    .i_we_o                 (I_WE_O),
    .i_cti_o                (I_CTI_O),
    .i_lock_o               (I_LOCK_O),
    .i_bte_o                (I_BTE_O),
    .instruction_f          (instruction_f),
    .instruction_d          (instruction_d)
    );
lm32_decoder_minimal decoder (
    .instruction            (instruction_d),
    .d_result_sel_0         (d_result_sel_0_d),
    .d_result_sel_1         (d_result_sel_1_d),
    .x_result_sel_csr       (x_result_sel_csr_d),
    .x_result_sel_shift     (x_result_sel_shift_d),
    .x_result_sel_logic     (x_result_sel_logic_d),
    .x_result_sel_add       (x_result_sel_add_d),
    .m_result_sel_compare   (m_result_sel_compare_d),
    .w_result_sel_load      (w_result_sel_load_d),
    .x_bypass_enable        (x_bypass_enable_d),
    .m_bypass_enable        (m_bypass_enable_d),
    .read_enable_0          (read_enable_0_d),
    .read_idx_0             (read_idx_0_d),
    .read_enable_1          (read_enable_1_d),
    .read_idx_1             (read_idx_1_d),
    .write_enable           (write_enable_d),
    .write_idx              (write_idx_d),
    .immediate              (immediate_d),
    .branch_offset          (branch_offset_d),
    .load                   (load_d),
    .store                  (store_d),
    .size                   (size_d),
    .sign_extend            (sign_extend_d),
    .adder_op               (adder_op_d),
    .logic_op               (logic_op_d),
    .branch                 (branch_d),
    .bi_unconditional       (bi_unconditional),
    .bi_conditional         (bi_conditional),
    .branch_reg             (branch_reg_d),
    .condition              (condition_d),
    .scall                  (scall_d),
    .eret                   (eret_d),
    .csr_write_enable       (csr_write_enable_d)
    ); 
lm32_load_store_unit_minimal #(
    .associativity          (dcache_associativity),
    .sets                   (dcache_sets),
    .bytes_per_line         (dcache_bytes_per_line),
    .base_address           (dcache_base_address),
    .limit                  (dcache_limit)
  ) load_store_unit (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_a                (stall_a),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .kill_x                 (kill_x),
    .kill_m                 (kill_m),
    .exception_m            (exception_m),
    .store_operand_x        (store_operand_x),
    .load_store_address_x   (adder_result_x),
    .load_store_address_m   (operand_m),
    .load_store_address_w   (operand_w[1:0]),
    .load_x                 (load_x),
    .store_x                (store_x),
    .load_q_x               (load_q_x),
    .store_q_x              (store_q_x),
    .load_q_m               (load_q_m),
    .store_q_m              (store_q_m),
    .sign_extend_x          (sign_extend_x),
    .size_x                 (size_x),
    .d_dat_i                (D_DAT_I),
    .d_ack_i                (D_ACK_I),
    .d_err_i                (D_ERR_I),
    .d_rty_i                (D_RTY_I),
    .load_data_w            (load_data_w),
    .stall_wb_load          (stall_wb_load),
    .d_dat_o                (D_DAT_O),
    .d_adr_o                (D_ADR_O),
    .d_cyc_o                (D_CYC_O),
    .d_sel_o                (D_SEL_O),
    .d_stb_o                (D_STB_O),
    .d_we_o                 (D_WE_O),
    .d_cti_o                (D_CTI_O),
    .d_lock_o               (D_LOCK_O),
    .d_bte_o                (D_BTE_O)
    );      
lm32_adder adder (
    .adder_op_x             (adder_op_x),
    .adder_op_x_n           (adder_op_x_n),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .adder_result_x         (adder_result_x),
    .adder_carry_n_x        (adder_carry_n_x),
    .adder_overflow_x       (adder_overflow_x)
    );
lm32_logic_op logic_op (
    .logic_op_x             (logic_op_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    .logic_result_x         (logic_result_x)
    );
lm32_interrupt_minimal interrupt_unit (
    .clk_i                  (clk_i), 
    .rst_i                  (rst_i),
    .interrupt              (interrupt),
    .stall_x                (stall_x),
    .exception              (exception_q_w), 
    .eret_q_x               (eret_q_x),
    .csr                    (csr_x),
    .csr_write_data         (operand_1_x),
    .csr_write_enable       (csr_write_enable_q_x),
    .interrupt_exception    (interrupt_exception),
    .csr_read_data          (interrupt_csr_read_data_x)
    );
   wire [31:0] regfile_data_0, regfile_data_1;
   reg [31:0]  w_result_d;
   reg 	       regfile_raw_0, regfile_raw_0_nxt;
   reg 	       regfile_raw_1, regfile_raw_1_nxt;
   always @(reg_write_enable_q_w or write_idx_w or instruction_f)
     begin
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[25:21]))
	  regfile_raw_0_nxt = 1'b1;
	else
	  regfile_raw_0_nxt = 1'b0;
	if (reg_write_enable_q_w
	    && (write_idx_w == instruction_f[20:16]))
	  regfile_raw_1_nxt = 1'b1;
	else
	  regfile_raw_1_nxt = 1'b0;
     end
   always @(regfile_raw_0 or w_result_d or regfile_data_0)
     if (regfile_raw_0)
       reg_data_live_0 = w_result_d;
     else
       reg_data_live_0 = regfile_data_0;
   always @(regfile_raw_1 or w_result_d or regfile_data_1)
     if (regfile_raw_1)
       reg_data_live_1 = w_result_d;
     else
       reg_data_live_1 = regfile_data_1;
   always @(posedge clk_i  )
     if (rst_i ==  1'b1)
       begin
	  regfile_raw_0 <= 1'b0;
	  regfile_raw_1 <= 1'b0;
	  w_result_d <= 32'b0;
       end
     else
       begin
	  regfile_raw_0 <= regfile_raw_0_nxt;
	  regfile_raw_1 <= regfile_raw_1_nxt;
	  w_result_d <= w_result;
       end
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_0
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[25:21]),
      .rdata_o	(regfile_data_0)
      );
   lm32_dp_ram
     #(
       .addr_depth(1<<5),
       .addr_width(5),
       .data_width(32)
       )
   reg_1
     (
      .clk_i	(clk_i),
      .rst_i	(rst_i), 
      .we_i	(reg_write_enable_q_w),
      .wdata_i	(w_result),
      .waddr_i	(write_idx_w),
      .raddr_i	(instruction_f[20:16]),
      .rdata_o	(regfile_data_1)
      );
assign reg_data_0 = use_buf ? reg_data_buf_0 : reg_data_live_0;
assign reg_data_1 = use_buf ? reg_data_buf_1 : reg_data_live_1;
assign raw_x_0 = (write_idx_x == read_idx_0_d) && (write_enable_q_x ==  1'b1);
assign raw_m_0 = (write_idx_m == read_idx_0_d) && (write_enable_q_m ==  1'b1);
assign raw_w_0 = (write_idx_w == read_idx_0_d) && (write_enable_q_w ==  1'b1);
assign raw_x_1 = (write_idx_x == read_idx_1_d) && (write_enable_q_x ==  1'b1);
assign raw_m_1 = (write_idx_m == read_idx_1_d) && (write_enable_q_m ==  1'b1);
assign raw_w_1 = (write_idx_w == read_idx_1_d) && (write_enable_q_w ==  1'b1);
always @(*)
begin
    if (   (   (x_bypass_enable_x ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_x_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_x_1 ==  1'b1))
               )
           )
        || (   (m_bypass_enable_m ==  1'b0)
            && (   ((read_enable_0_d ==  1'b1) && (raw_m_0 ==  1'b1))
                || ((read_enable_1_d ==  1'b1) && (raw_m_1 ==  1'b1))
               )
           )
       )
        interlock =  1'b1;
    else
        interlock =  1'b0;
end
always @(*)
begin
    if (raw_x_0 ==  1'b1)        
        bypass_data_0 = x_result;
    else if (raw_m_0 ==  1'b1)
        bypass_data_0 = m_result;
    else if (raw_w_0 ==  1'b1)
        bypass_data_0 = w_result;
    else
        bypass_data_0 = reg_data_0;
end
always @(*)
begin
    if (raw_x_1 ==  1'b1)
        bypass_data_1 = x_result;
    else if (raw_m_1 ==  1'b1)
        bypass_data_1 = m_result;
    else if (raw_w_1 ==  1'b1)
        bypass_data_1 = w_result;
    else
        bypass_data_1 = reg_data_1;
end
   assign branch_predict_d = bi_unconditional | bi_conditional;
   assign branch_predict_taken_d = bi_unconditional ? 1'b1 : (bi_conditional ? instruction_d[15] : 1'b0);
   assign branch_target_d = pc_d + branch_offset_d;
   assign branch_predict_address_d = branch_predict_taken_d ? branch_target_d : pc_f;
always @(*)
begin
    d_result_0 = d_result_sel_0_d[0] ? {pc_f, 2'b00} : bypass_data_0; 
    case (d_result_sel_1_d)
     2'b00:      d_result_1 = { 32{1'b0}};
     2'b01:     d_result_1 = bypass_data_1;
     2'b10: d_result_1 = immediate_d;
    default:                        d_result_1 = { 32{1'bx}};
    endcase
end
assign shifter_result_x = {operand_0_x[ 32-1] & sign_extend_x, operand_0_x[ 32-1:1]};
assign cmp_zero = operand_0_x == operand_1_x;
assign cmp_negative = adder_result_x[ 32-1];
assign cmp_overflow = adder_overflow_x;
assign cmp_carry_n = adder_carry_n_x;
always @(*)
begin
    case (condition_x)
     3'b000:   condition_met_x =  1'b1;
     3'b110:   condition_met_x =  1'b1;
     3'b001:    condition_met_x = cmp_zero;
     3'b111:   condition_met_x = !cmp_zero;
     3'b010:    condition_met_x = !cmp_zero && (cmp_negative == cmp_overflow);
     3'b101:   condition_met_x = cmp_carry_n && !cmp_zero;
     3'b011:   condition_met_x = cmp_negative == cmp_overflow;
     3'b100:  condition_met_x = cmp_carry_n;
    default:              condition_met_x = 1'bx;
    endcase 
end
always @(*)
begin
    x_result =   x_result_sel_add_x ? adder_result_x 
               : x_result_sel_csr_x ? csr_read_data_x
               : x_result_sel_shift_x ? shifter_result_x
               : logic_result_x;
end
always @(*)
begin
    m_result =   m_result_sel_compare_m ? {{ 32-1{1'b0}}, condition_met_m}
               : operand_m; 
end
always @(*)
begin
    w_result =    w_result_sel_load_w ? load_data_w
                : operand_w;
end
assign branch_taken_m =      (stall_m ==  1'b0) 
                          && (   (   (branch_m ==  1'b1) 
                                  && (valid_m ==  1'b1)
                                  && (   (   (condition_met_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b0)
					 )
				      || (   (condition_met_m ==  1'b0)
					  && (branch_predict_m ==  1'b1)
					  && (branch_predict_taken_m ==  1'b1)
					 )
				     )
                                 ) 
                              || (exception_m ==  1'b1)
                             );
assign branch_mispredict_taken_m =    (condition_met_m ==  1'b0)
                                   && (branch_predict_m ==  1'b1)
	   			   && (branch_predict_taken_m ==  1'b1);
assign branch_flushX_m =    (stall_m ==  1'b0)
                         && (   (   (branch_m ==  1'b1) 
                                 && (valid_m ==  1'b1)
			         && (   (condition_met_m ==  1'b1)
				     || (   (condition_met_m ==  1'b0)
					 && (branch_predict_m ==  1'b1)
					 && (branch_predict_taken_m ==  1'b1)
					)
				    )
			        )
			     || (exception_m ==  1'b1)
			    );
assign kill_f =    (   (valid_d ==  1'b1)
                    && (branch_predict_taken_d ==  1'b1)
		   )
                || (branch_taken_m ==  1'b1) 
                ;
assign kill_d =    (branch_taken_m ==  1'b1) 
                ;
assign kill_x =    (branch_flushX_m ==  1'b1) 
                ;
assign kill_m =     1'b0
                ;                
assign kill_w =     1'b0
                ;
assign system_call_exception = (   (scall_x ==  1'b1)
			       );
assign exception_x =           (system_call_exception ==  1'b1)
                            || (   (interrupt_exception ==  1'b1)
                               )
                            ;
always @(*)
begin
         if (   (interrupt_exception ==  1'b1)
            )
        eid_x =  3'h6;
    else
        eid_x =  3'h7;
end
assign stall_a = (stall_f ==  1'b1);
assign stall_f = (stall_d ==  1'b1);
assign stall_d =   (stall_x ==  1'b1) 
                || (   (interlock ==  1'b1)
                    && (kill_d ==  1'b0)
                   ) 
		|| (   (   (eret_d ==  1'b1)
			|| (scall_d ==  1'b1)
		       )
		    && (   (load_q_x ==  1'b1)
			|| (load_q_m ==  1'b1)
			|| (store_q_x ==  1'b1)
			|| (store_q_m ==  1'b1)
			|| (D_CYC_O ==  1'b1)
		       )
                    && (kill_d ==  1'b0)
		   )
                || (   (csr_write_enable_d ==  1'b1)
                    && (load_q_x ==  1'b1)
                   )                      
                ;
assign stall_x =    (stall_m ==  1'b1)
                 ;
assign stall_m =    (stall_wb_load ==  1'b1)
                 || (   (D_CYC_O ==  1'b1)
                     && (   (store_m ==  1'b1)
		         || ((store_x ==  1'b1) && (interrupt_exception ==  1'b1))
                         || (load_m ==  1'b1)
                         || (load_x ==  1'b1)
                        ) 
                    ) 
                 || (I_CYC_O ==  1'b1)            
                 ;      
assign q_x = (valid_x ==  1'b1) && (kill_x ==  1'b0);
assign csr_write_enable_q_x = (csr_write_enable_x ==  1'b1) && (q_x ==  1'b1);
assign eret_q_x = (eret_x ==  1'b1) && (q_x ==  1'b1);
assign load_q_x = (load_x ==  1'b1) 
               && (q_x ==  1'b1)
                  ;
assign store_q_x = (store_x ==  1'b1) 
               && (q_x ==  1'b1)
                  ;
assign q_m = (valid_m ==  1'b1) && (kill_m ==  1'b0) && (exception_m ==  1'b0);
assign load_q_m = (load_m ==  1'b1) && (q_m ==  1'b1);
assign store_q_m = (store_m ==  1'b1) && (q_m ==  1'b1);
assign exception_q_w = ((exception_w ==  1'b1) && (valid_w ==  1'b1));        
assign write_enable_q_x = (write_enable_x ==  1'b1) && (valid_x ==  1'b1) && (branch_flushX_m ==  1'b0);
assign write_enable_q_m = (write_enable_m ==  1'b1) && (valid_m ==  1'b1);
assign write_enable_q_w = (write_enable_w ==  1'b1) && (valid_w ==  1'b1);
assign reg_write_enable_q_w = (write_enable_w ==  1'b1) && (kill_w ==  1'b0) && (valid_w ==  1'b1);
assign cfg = {
               6'h02,
              watchpoints[3:0],
              breakpoints[3:0],
              interrupts[5:0],
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b0,
               1'b0
              };
assign cfg2 = {
		     30'b0,
		      1'b0,
		      1'b0
		     };
assign csr_d = read_idx_0_d[ (4 -1):0];
always @(*)
begin
    case (csr_x)
     4 'h0,
     4 'h1,
     4 'h2:   csr_read_data_x = interrupt_csr_read_data_x;  
     4 'h6:  csr_read_data_x = cfg;
     4 'h7:  csr_read_data_x = {eba, 8'h00};
     4 'ha: csr_read_data_x = cfg2;
     4 'hb:  csr_read_data_x = sdb_address;
    default:        csr_read_data_x = { 32{1'bx}};
    endcase
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
        eba <= eba_reset[ (32-2)+2-1:8];
    else
    begin
        if ((csr_write_enable_q_x ==  1'b1) && (csr_x ==  4 'h7) && (stall_x ==  1'b0))
            eba <= operand_1_x[ (32-2)+2-1:8];
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        valid_f <=  1'b0;
        valid_d <=  1'b0;
        valid_x <=  1'b0;
        valid_m <=  1'b0;
        valid_w <=  1'b0;
    end
    else
    begin    
        if ((kill_f ==  1'b1) || (stall_a ==  1'b0))
            valid_f <=  1'b1;
        else if (stall_f ==  1'b0)
            valid_f <=  1'b0;            
        if (kill_d ==  1'b1)
            valid_d <=  1'b0;
        else if (stall_f ==  1'b0)
            valid_d <= valid_f & !kill_f;
        else if (stall_d ==  1'b0)
            valid_d <=  1'b0;
        if (stall_d ==  1'b0)
            valid_x <= valid_d & !kill_d;
        else if (kill_x ==  1'b1)
            valid_x <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_x <=  1'b0;
        if (kill_m ==  1'b1)
            valid_m <=  1'b0;
        else if (stall_x ==  1'b0)
            valid_m <= valid_x & !kill_x;
        else if (stall_m ==  1'b0)
            valid_m <=  1'b0;
        if (stall_m ==  1'b0)
            valid_w <= valid_m & !kill_m;
        else 
            valid_w <=  1'b0;        
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        operand_0_x <= { 32{1'b0}};
        operand_1_x <= { 32{1'b0}};
        store_operand_x <= { 32{1'b0}};
        branch_target_x <= { (32-2){1'b0}};        
        x_result_sel_csr_x <=  1'b0;
        x_result_sel_shift_x <=  1'b0;
        x_result_sel_add_x <=  1'b0;
        m_result_sel_compare_x <=  1'b0;
        w_result_sel_load_x <=  1'b0;
        x_bypass_enable_x <=  1'b0;
        m_bypass_enable_x <=  1'b0;
        write_enable_x <=  1'b0;
        write_idx_x <= { 5{1'b0}};
        csr_x <= { 4 {1'b0}};
        load_x <=  1'b0;
        store_x <=  1'b0;
        size_x <= { 2{1'b0}};
        sign_extend_x <=  1'b0;
        adder_op_x <=  1'b0;
        adder_op_x_n <=  1'b0;
        logic_op_x <= 4'h0;
        branch_x <=  1'b0;
        branch_predict_x <=  1'b0;
        branch_predict_taken_x <=  1'b0;
        condition_x <=  3'b000;
        scall_x <=  1'b0;
        eret_x <=  1'b0;
        csr_write_enable_x <=  1'b0;
        operand_m <= { 32{1'b0}};
        branch_target_m <= { (32-2){1'b0}};
        m_result_sel_compare_m <=  1'b0;
        w_result_sel_load_m <=  1'b0;
        m_bypass_enable_m <=  1'b0;
        branch_m <=  1'b0;
        branch_predict_m <=  1'b0;
	branch_predict_taken_m <=  1'b0;
        exception_m <=  1'b0;
        load_m <=  1'b0;
        store_m <=  1'b0;
        write_enable_m <=  1'b0;            
        write_idx_m <= { 5{1'b0}};
        condition_met_m <=  1'b0;
        operand_w <= { 32{1'b0}};        
        w_result_sel_load_w <=  1'b0;
        write_idx_w <= { 5{1'b0}};        
        write_enable_w <=  1'b0;
        exception_w <=  1'b0;
    end
    else
    begin
        if (stall_x ==  1'b0)
        begin
            operand_0_x <= d_result_0;
            operand_1_x <= d_result_1;
            store_operand_x <= bypass_data_1;
            branch_target_x <= branch_reg_d ==  1'b1 ? bypass_data_0[ ((32-2)+2-1):2] : branch_target_d;            
            x_result_sel_csr_x <= x_result_sel_csr_d;
            x_result_sel_shift_x <= x_result_sel_shift_d;
            x_result_sel_add_x <= x_result_sel_add_d;
            m_result_sel_compare_x <= m_result_sel_compare_d;
            w_result_sel_load_x <= w_result_sel_load_d;
            x_bypass_enable_x <= x_bypass_enable_d;
            m_bypass_enable_x <= m_bypass_enable_d;
            load_x <= load_d;
            store_x <= store_d;
            branch_x <= branch_d;
	    branch_predict_x <= branch_predict_d;
	    branch_predict_taken_x <= branch_predict_taken_d;
	    write_idx_x <= write_idx_d;
            csr_x <= csr_d;
            size_x <= size_d;
            sign_extend_x <= sign_extend_d;
            adder_op_x <= adder_op_d;
            adder_op_x_n <= ~adder_op_d;
            logic_op_x <= logic_op_d;
            condition_x <= condition_d;
            csr_write_enable_x <= csr_write_enable_d;
            scall_x <= scall_d;
            eret_x <= eret_d;
            write_enable_x <= write_enable_d;
        end
        if (stall_m ==  1'b0)
        begin
            operand_m <= x_result;
            m_result_sel_compare_m <= m_result_sel_compare_x;
            if (exception_x ==  1'b1)
            begin
                w_result_sel_load_m <=  1'b0;
            end
            else
            begin
                w_result_sel_load_m <= w_result_sel_load_x;
            end
            m_bypass_enable_m <= m_bypass_enable_x;
            load_m <= load_x;
            store_m <= store_x;
            branch_m <= branch_x;
	    branch_predict_m <= branch_predict_x;
	    branch_predict_taken_m <= branch_predict_taken_x;
            if (exception_x ==  1'b1)
                write_idx_m <=  5'd30;
            else 
                write_idx_m <= write_idx_x;
            condition_met_m <= condition_met_x;
            branch_target_m <= exception_x ==  1'b1 ? {eba, eid_x, {3{1'b0}}} : branch_target_x;
            write_enable_m <= exception_x ==  1'b1 ?  1'b1 : write_enable_x;            
        end
        if (stall_m ==  1'b0)
        begin
            if ((exception_x ==  1'b1) && (q_x ==  1'b1) && (stall_x ==  1'b0))
                exception_m <=  1'b1;
            else 
                exception_m <=  1'b0;
	end
        operand_w <= exception_m ==  1'b1 ? {pc_m, 2'b00} : m_result;
        w_result_sel_load_w <= w_result_sel_load_m;
        write_idx_w <= write_idx_m;
        write_enable_w <= write_enable_m;
        exception_w <= exception_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        use_buf <=  1'b0;
        reg_data_buf_0 <= { 32{1'b0}};
        reg_data_buf_1 <= { 32{1'b0}};
    end
    else
    begin
        if (stall_d ==  1'b0)
            use_buf <=  1'b0;
        else if (use_buf ==  1'b0)
        begin        
            reg_data_buf_0 <= reg_data_live_0;
            reg_data_buf_1 <= reg_data_live_1;
            use_buf <=  1'b1;
        end        
        if (reg_write_enable_q_w ==  1'b1)
        begin
            if (write_idx_w == read_idx_0_d)
                reg_data_buf_0 <= w_result;
            if (write_idx_w == read_idx_1_d)
                reg_data_buf_1 <= w_result;
        end
    end
end
initial
begin
end
endmodule 
module lm32_load_store_unit_minimal (
    clk_i,
    rst_i,
    stall_a,
    stall_x,
    stall_m,
    kill_x,
    kill_m,
    exception_m,
    store_operand_x,
    load_store_address_x,
    load_store_address_m,
    load_store_address_w,
    load_x,
    store_x,
    load_q_x,
    store_q_x,
    load_q_m,
    store_q_m,
    sign_extend_x,
    size_x,
    d_dat_i,
    d_ack_i,
    d_err_i,
    d_rty_i,
    load_data_w,
    stall_wb_load,
    d_dat_o,
    d_adr_o,
    d_cyc_o,
    d_sel_o,
    d_stb_o,
    d_we_o,
    d_cti_o,
    d_lock_o,
    d_bte_o
    );
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_x;                                          
input stall_m;                                          
input kill_x;                                           
input kill_m;                                           
input exception_m;                                      
input [ (32-1):0] store_operand_x;                 
input [ (32-1):0] load_store_address_x;            
input [ (32-1):0] load_store_address_m;            
input [1:0] load_store_address_w;                       
input load_x;                                           
input store_x;                                          
input load_q_x;                                         
input store_q_x;                                        
input load_q_m;                                         
input store_q_m;                                        
input sign_extend_x;                                    
input [ 1:0] size_x;                          
input [ (32-1):0] d_dat_i;                         
input d_ack_i;                                          
input d_err_i;                                          
input d_rty_i;                                          
output [ (32-1):0] load_data_w;                    
reg    [ (32-1):0] load_data_w;
output stall_wb_load;                                   
reg    stall_wb_load;
output [ (32-1):0] d_dat_o;                        
reg    [ (32-1):0] d_dat_o;
output [ (32-1):0] d_adr_o;                        
reg    [ (32-1):0] d_adr_o;
output d_cyc_o;                                         
reg    d_cyc_o;
output [ (4-1):0] d_sel_o;                 
reg    [ (4-1):0] d_sel_o;
output d_stb_o;                                         
reg    d_stb_o; 
output d_we_o;                                          
reg    d_we_o;
output [ (3-1):0] d_cti_o;                       
reg    [ (3-1):0] d_cti_o;
output d_lock_o;                                        
reg    d_lock_o;
output [ (2-1):0] d_bte_o;                       
wire   [ (2-1):0] d_bte_o;
reg [ 1:0] size_m;
reg [ 1:0] size_w;
reg sign_extend_m;
reg sign_extend_w;
reg [ (32-1):0] store_data_x;       
reg [ (32-1):0] store_data_m;       
reg [ (4-1):0] byte_enable_x;
reg [ (4-1):0] byte_enable_m;
wire [ (32-1):0] data_m;
reg [ (32-1):0] data_w;
wire wb_select_x;                                       
reg wb_select_m;
reg [ (32-1):0] wb_data_m;                         
reg wb_load_complete;                                   
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
   assign wb_select_x =     1'b1
                     ;
always @(*)
begin
    case (size_x)
     2'b00:  store_data_x = {4{store_operand_x[7:0]}};
     2'b11: store_data_x = {2{store_operand_x[15:0]}};
     2'b10:  store_data_x = store_operand_x;    
    default:          store_data_x = { 32{1'bx}};
    endcase
end
always @(*)
begin
    casez ({size_x, load_store_address_x[1:0]})
    { 2'b00, 2'b11}:  byte_enable_x = 4'b0001;
    { 2'b00, 2'b10}:  byte_enable_x = 4'b0010;
    { 2'b00, 2'b01}:  byte_enable_x = 4'b0100;
    { 2'b00, 2'b00}:  byte_enable_x = 4'b1000;
    { 2'b11, 2'b1?}: byte_enable_x = 4'b0011;
    { 2'b11, 2'b0?}: byte_enable_x = 4'b1100;
    { 2'b10, 2'b??}:  byte_enable_x = 4'b1111;
    default:                   byte_enable_x = 4'bxxxx;
    endcase
end
   assign data_m = wb_data_m;
always @(*)
begin
    casez ({size_w, load_store_address_w[1:0]})
    { 2'b00, 2'b11}:  load_data_w = {{24{sign_extend_w & data_w[7]}}, data_w[7:0]};
    { 2'b00, 2'b10}:  load_data_w = {{24{sign_extend_w & data_w[15]}}, data_w[15:8]};
    { 2'b00, 2'b01}:  load_data_w = {{24{sign_extend_w & data_w[23]}}, data_w[23:16]};
    { 2'b00, 2'b00}:  load_data_w = {{24{sign_extend_w & data_w[31]}}, data_w[31:24]};
    { 2'b11, 2'b1?}: load_data_w = {{16{sign_extend_w & data_w[15]}}, data_w[15:0]};
    { 2'b11, 2'b0?}: load_data_w = {{16{sign_extend_w & data_w[31]}}, data_w[31:16]};
    { 2'b10, 2'b??}:  load_data_w = data_w;
    default:                   load_data_w = { 32{1'bx}};
    endcase
end
assign d_bte_o =  2'b00;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        d_cyc_o <=  1'b0;
        d_stb_o <=  1'b0;
        d_dat_o <= { 32{1'b0}};
        d_adr_o <= { 32{1'b0}};
        d_sel_o <= { 4{ 1'b0}};
        d_we_o <=  1'b0;
        d_cti_o <=  3'b111;
        d_lock_o <=  1'b0;
        wb_data_m <= { 32{1'b0}};
        wb_load_complete <=  1'b0;
        stall_wb_load <=  1'b0;
    end
    else
    begin
        if (d_cyc_o ==  1'b1)
        begin
            if ((d_ack_i ==  1'b1) || (d_err_i ==  1'b1))
            begin
                begin
                    d_cyc_o <=  1'b0;
                    d_stb_o <=  1'b0;
                    d_lock_o <=  1'b0;
                end
                wb_data_m <= d_dat_i;
                wb_load_complete <= !d_we_o;
            end
            if (d_err_i ==  1'b1)
                $display ("Data bus error. Address: %x", d_adr_o);
        end
        else
        begin
                 if (   (store_q_m ==  1'b1)
                     && (stall_m ==  1'b0)
                    )
            begin
                d_dat_o <= store_data_m;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b1;
                d_cti_o <=  3'b111;
            end        
            else if (   (load_q_m ==  1'b1) 
                     && (wb_select_m ==  1'b1) 
                     && (wb_load_complete ==  1'b0)
                    )
            begin
                stall_wb_load <=  1'b0;
                d_adr_o <= load_store_address_m;
                d_cyc_o <=  1'b1;
                d_sel_o <= byte_enable_m;
                d_stb_o <=  1'b1;
                d_we_o <=  1'b0;
                d_cti_o <=  3'b111;
            end
        end
        if (stall_m ==  1'b0)
            wb_load_complete <=  1'b0;
        if ((load_q_x ==  1'b1) && (wb_select_x ==  1'b1) && (stall_x ==  1'b0))
            stall_wb_load <=  1'b1;
        if ((kill_m ==  1'b1) || (exception_m ==  1'b1))
            stall_wb_load <=  1'b0;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        sign_extend_m <=  1'b0;
        size_m <= 2'b00;
        byte_enable_m <=  1'b0;
        store_data_m <= { 32{1'b0}};
        wb_select_m <=  1'b0;        
    end
    else
    begin
        if (stall_m ==  1'b0)
        begin
            sign_extend_m <= sign_extend_x;
            size_m <= size_x;
            byte_enable_m <= byte_enable_x;    
            store_data_m <= store_data_x;
            wb_select_m <= wb_select_x;
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        size_w <= 2'b00;
        data_w <= { 32{1'b0}};
        sign_extend_w <=  1'b0;
    end
    else
    begin
        size_w <= size_m;
        data_w <= data_m;
        sign_extend_w <= sign_extend_m;
    end
end
always @(posedge clk_i)
begin
    if (((load_q_m ==  1'b1) || (store_q_m ==  1'b1)) && (stall_m ==  1'b0)) 
    begin
        if ((size_m ===  2'b11) && (load_store_address_m[0] !== 1'b0))
            $display ("Warning: Non-aligned halfword access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
        if ((size_m ===  2'b10) && (load_store_address_m[1:0] !== 2'b00))
            $display ("Warning: Non-aligned word access. Address: 0x%0x Time: %0t.", load_store_address_m, $time);
    end
end
endmodule
module lm32_decoder_minimal (
    instruction,
    d_result_sel_0,
    d_result_sel_1,        
    x_result_sel_csr,
    x_result_sel_shift,
    x_result_sel_logic,
    x_result_sel_add,
    m_result_sel_compare,
    w_result_sel_load,
    x_bypass_enable,
    m_bypass_enable,
    read_enable_0,
    read_idx_0,
    read_enable_1,
    read_idx_1,
    write_enable,
    write_idx,
    immediate,
    branch_offset,
    load,
    store,
    size,
    sign_extend,
    adder_op,
    logic_op,
    branch,
    branch_reg,
    condition,
    bi_conditional,
    bi_unconditional,
    scall,
    eret,
    csr_write_enable
    );
input [ (32-1):0] instruction;       
output [ 0:0] d_result_sel_0;
reg    [ 0:0] d_result_sel_0;
output [ 1:0] d_result_sel_1;
reg    [ 1:0] d_result_sel_1;
output x_result_sel_csr;
reg    x_result_sel_csr;
output x_result_sel_shift;
reg    x_result_sel_shift;
output x_result_sel_logic;
reg    x_result_sel_logic;
output x_result_sel_add;
reg    x_result_sel_add;
output m_result_sel_compare;
reg    m_result_sel_compare;
output w_result_sel_load;
reg    w_result_sel_load;
output x_bypass_enable;
wire   x_bypass_enable;
output m_bypass_enable;
wire   m_bypass_enable;
output read_enable_0;
wire   read_enable_0;
output [ (5-1):0] read_idx_0;
wire   [ (5-1):0] read_idx_0;
output read_enable_1;
wire   read_enable_1;
output [ (5-1):0] read_idx_1;
wire   [ (5-1):0] read_idx_1;
output write_enable;
wire   write_enable;
output [ (5-1):0] write_idx;
wire   [ (5-1):0] write_idx;
output [ (32-1):0] immediate;
wire   [ (32-1):0] immediate;
output [ ((32-2)+2-1):2] branch_offset;
wire   [ ((32-2)+2-1):2] branch_offset;
output load;
wire   load;
output store;
wire   store;
output [ 1:0] size;
wire   [ 1:0] size;
output sign_extend;
wire   sign_extend;
output adder_op;
wire   adder_op;
output [ 3:0] logic_op;
wire   [ 3:0] logic_op;
output branch;
wire   branch;
output branch_reg;
wire   branch_reg;
output [ (3-1):0] condition;
wire   [ (3-1):0] condition;
output bi_conditional;
wire bi_conditional;
output bi_unconditional;
wire bi_unconditional;
output scall;
wire   scall;
output eret;
wire   eret;
output csr_write_enable;
wire   csr_write_enable;
wire [ (32-1):0] extended_immediate;       
wire [ (32-1):0] high_immediate;           
wire [ (32-1):0] call_immediate;           
wire [ (32-1):0] branch_immediate;         
wire sign_extend_immediate;                     
wire select_high_immediate;                     
wire select_call_immediate;                     
wire op_add;
wire op_and;
wire op_andhi;
wire op_b;
wire op_bi;
wire op_be;
wire op_bg;
wire op_bge;
wire op_bgeu;
wire op_bgu;
wire op_bne;
wire op_call;
wire op_calli;
wire op_cmpe;
wire op_cmpg;
wire op_cmpge;
wire op_cmpgeu;
wire op_cmpgu;
wire op_cmpne;
wire op_lb;
wire op_lbu;
wire op_lh;
wire op_lhu;
wire op_lw;
wire op_nor;
wire op_or;
wire op_orhi;
wire op_raise;
wire op_rcsr;
wire op_sb;
wire op_sh;
wire op_sr;
wire op_sru;
wire op_sub;
wire op_sw;
wire op_wcsr;
wire op_xnor;
wire op_xor;
wire arith;
wire logical;
wire cmp;
wire bra;
wire call;
wire shift;
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
assign op_add    = instruction[ 30:26] ==  5'b01101;
assign op_and    = instruction[ 30:26] ==  5'b01000;
assign op_andhi  = instruction[ 31:26] ==  6'b011000;
assign op_b      = instruction[ 31:26] ==  6'b110000;
assign op_bi     = instruction[ 31:26] ==  6'b111000;
assign op_be     = instruction[ 31:26] ==  6'b010001;
assign op_bg     = instruction[ 31:26] ==  6'b010010;
assign op_bge    = instruction[ 31:26] ==  6'b010011;
assign op_bgeu   = instruction[ 31:26] ==  6'b010100;
assign op_bgu    = instruction[ 31:26] ==  6'b010101;
assign op_bne    = instruction[ 31:26] ==  6'b010111;
assign op_call   = instruction[ 31:26] ==  6'b110110;
assign op_calli  = instruction[ 31:26] ==  6'b111110;
assign op_cmpe   = instruction[ 30:26] ==  5'b11001;
assign op_cmpg   = instruction[ 30:26] ==  5'b11010;
assign op_cmpge  = instruction[ 30:26] ==  5'b11011;
assign op_cmpgeu = instruction[ 30:26] ==  5'b11100;
assign op_cmpgu  = instruction[ 30:26] ==  5'b11101;
assign op_cmpne  = instruction[ 30:26] ==  5'b11111;
assign op_lb     = instruction[ 31:26] ==  6'b000100;
assign op_lbu    = instruction[ 31:26] ==  6'b010000;
assign op_lh     = instruction[ 31:26] ==  6'b000111;
assign op_lhu    = instruction[ 31:26] ==  6'b001011;
assign op_lw     = instruction[ 31:26] ==  6'b001010;
assign op_nor    = instruction[ 30:26] ==  5'b00001;
assign op_or     = instruction[ 30:26] ==  5'b01110;
assign op_orhi   = instruction[ 31:26] ==  6'b011110;
assign op_raise  = instruction[ 31:26] ==  6'b101011;
assign op_rcsr   = instruction[ 31:26] ==  6'b100100;
assign op_sb     = instruction[ 31:26] ==  6'b001100;
assign op_sh     = instruction[ 31:26] ==  6'b000011;
assign op_sr     = instruction[ 30:26] ==  5'b00101;
assign op_sru    = instruction[ 30:26] ==  5'b00000;
assign op_sub    = instruction[ 31:26] ==  6'b110010;
assign op_sw     = instruction[ 31:26] ==  6'b010110;
assign op_wcsr   = instruction[ 31:26] ==  6'b110100;
assign op_xnor   = instruction[ 30:26] ==  5'b01001;
assign op_xor    = instruction[ 30:26] ==  5'b00110;
assign arith = op_add | op_sub;
assign logical = op_and | op_andhi | op_nor | op_or | op_orhi | op_xor | op_xnor;
assign cmp = op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne;
assign bi_conditional = op_be | op_bg | op_bge | op_bgeu  | op_bgu | op_bne;
assign bi_unconditional = op_bi;
assign bra = op_b | bi_unconditional | bi_conditional;
assign call = op_call | op_calli;
assign shift = op_sr | op_sru;
assign load = op_lb | op_lbu | op_lh | op_lhu | op_lw;
assign store = op_sb | op_sh | op_sw;
always @(*)
begin
    if (call) 
        d_result_sel_0 =  1'b1;
    else 
        d_result_sel_0 =  1'b0;
    if (call) 
        d_result_sel_1 =  2'b00;         
    else if ((instruction[31] == 1'b0) && !bra) 
        d_result_sel_1 =  2'b10;
    else
        d_result_sel_1 =  2'b01; 
    x_result_sel_csr =  1'b0;
    x_result_sel_shift =  1'b0;
    x_result_sel_logic =  1'b0;
    x_result_sel_add =  1'b0;
    if (op_rcsr)
        x_result_sel_csr =  1'b1;
    else if (shift)
        x_result_sel_shift =  1'b1;        
    else if (logical) 
        x_result_sel_logic =  1'b1;
    else 
        x_result_sel_add =  1'b1;        
    m_result_sel_compare = cmp;
    w_result_sel_load = load;
end
assign x_bypass_enable =  arith 
                        | logical
                        | shift
                        | op_rcsr
                        ;
assign m_bypass_enable = x_bypass_enable 
                        | cmp
                        ;
assign read_enable_0 = ~(op_bi | op_calli);
assign read_idx_0 = instruction[25:21];
assign read_enable_1 = ~(op_bi | op_calli | load);
assign read_idx_1 = instruction[20:16];
assign write_enable = ~(bra | op_raise | store | op_wcsr);
assign write_idx = call
                    ? 5'd29
                    : instruction[31] == 1'b0 
                        ? instruction[20:16] 
                        : instruction[15:11];
assign size = instruction[27:26];
assign sign_extend = instruction[28];                      
assign adder_op = op_sub | op_cmpe | op_cmpg | op_cmpge | op_cmpgeu | op_cmpgu | op_cmpne | bra;
assign logic_op = instruction[29:26];
assign branch = bra | call;
assign branch_reg = op_call | op_b;
assign condition = instruction[28:26];      
assign scall = op_raise & instruction[2];
assign eret = op_b & (instruction[25:21] == 5'd30);
assign csr_write_enable = op_wcsr;
assign sign_extend_immediate = ~(op_and | op_cmpgeu | op_cmpgu | op_nor | op_or | op_xnor | op_xor);
assign select_high_immediate = op_andhi | op_orhi;
assign select_call_immediate = instruction[31];
assign high_immediate = {instruction[15:0], 16'h0000};
assign extended_immediate = {{16{sign_extend_immediate & instruction[15]}}, instruction[15:0]};
assign call_immediate = {{6{instruction[25]}}, instruction[25:0]};
assign branch_immediate = {{16{instruction[15]}}, instruction[15:0]};
assign immediate = select_high_immediate ==  1'b1 
                        ? high_immediate 
                        : extended_immediate;
assign branch_offset = select_call_immediate ==  1'b1   
                        ? (call_immediate[ (32-2)-1:0])
                        : (branch_immediate[ (32-2)-1:0]);
endmodule 
module lm32_instruction_unit_minimal (
    clk_i,
    rst_i,
    stall_a,
    stall_f,
    stall_d,
    stall_x,
    stall_m,
    valid_f,
    valid_d,
    kill_f,
    branch_predict_taken_d,
    branch_predict_address_d,
    exception_m,
    branch_taken_m,
    branch_mispredict_taken_m,
    branch_target_m,
    i_dat_i,
    i_ack_i,
    i_err_i,
    i_rty_i,
    pc_f,
    pc_d,
    pc_x,
    pc_m,
    pc_w,
    i_dat_o,
    i_adr_o,
    i_cyc_o,
    i_sel_o,
    i_stb_o,
    i_we_o,
    i_cti_o,
    i_lock_o,
    i_bte_o,
    instruction_f,
    instruction_d
    );
parameter eba_reset =  32'h00000000;                   
parameter associativity = 1;                            
parameter sets = 512;                                   
parameter bytes_per_line = 16;                          
parameter base_address = 0;                             
parameter limit = 0;                                    
localparam eba_reset_minus_4 = eba_reset - 4;
localparam addr_offset_width = bytes_per_line == 4 ? 1 : clogb2(bytes_per_line)-1-2;
localparam addr_offset_lsb = 2;
localparam addr_offset_msb = (addr_offset_lsb+addr_offset_width-1);
input clk_i;                                            
input rst_i;                                            
input stall_a;                                          
input stall_f;                                          
input stall_d;                                          
input stall_x;                                          
input stall_m;                                          
input valid_f;                                          
input valid_d;                                          
input kill_f;                                           
input branch_predict_taken_d;                           
input [ ((32-2)+2-1):2] branch_predict_address_d;          
input exception_m;
input branch_taken_m;                                   
input branch_mispredict_taken_m;                        
input [ ((32-2)+2-1):2] branch_target_m;                   
input [ (32-1):0] i_dat_i;                         
input i_ack_i;                                          
input i_err_i;                                          
input i_rty_i;                                          
output [ ((32-2)+2-1):2] pc_f;                             
reg    [ ((32-2)+2-1):2] pc_f;
output [ ((32-2)+2-1):2] pc_d;                             
reg    [ ((32-2)+2-1):2] pc_d;
output [ ((32-2)+2-1):2] pc_x;                             
reg    [ ((32-2)+2-1):2] pc_x;
output [ ((32-2)+2-1):2] pc_m;                             
reg    [ ((32-2)+2-1):2] pc_m;
output [ ((32-2)+2-1):2] pc_w;                             
reg    [ ((32-2)+2-1):2] pc_w;
output [ (32-1):0] i_dat_o;                        
wire   [ (32-1):0] i_dat_o;
output [ (32-1):0] i_adr_o;                        
reg    [ (32-1):0] i_adr_o;
output i_cyc_o;                                         
reg    i_cyc_o; 
output [ (4-1):0] i_sel_o;                 
wire   [ (4-1):0] i_sel_o;
output i_stb_o;                                         
reg    i_stb_o;
output i_we_o;                                          
wire   i_we_o;
output [ (3-1):0] i_cti_o;                       
reg    [ (3-1):0] i_cti_o;
output i_lock_o;                                        
reg    i_lock_o;
output [ (2-1):0] i_bte_o;                       
wire   [ (2-1):0] i_bte_o;
output [ (32-1):0] instruction_f;           
wire   [ (32-1):0] instruction_f;
output [ (32-1):0] instruction_d;           
reg    [ (32-1):0] instruction_d;
reg [ ((32-2)+2-1):2] pc_a;                                
reg [ (32-1):0] wb_data_f;                  
function integer clogb2;
input [31:0] value;
begin
   for (clogb2 = 0; value > 0; clogb2 = clogb2 + 1)
        value = value >> 1;
end
endfunction 
function integer clogb2_v1;
input [31:0] value;
reg   [31:0] i;
reg   [31:0] temp;
begin
   temp = 0;
   i    = 0;
   for (i = 0; temp < value; i = i + 1)  
	temp = 1<<i;
   clogb2_v1 = i-1;
end
endfunction
always @(*)
begin
      if (branch_taken_m ==  1'b1)
	if ((branch_mispredict_taken_m ==  1'b1) && (exception_m ==  1'b0))
	  pc_a = pc_x;
	else
          pc_a = branch_target_m;
      else
	if ( (valid_d ==  1'b1) && (branch_predict_taken_d ==  1'b1) )
	  pc_a = branch_predict_address_d;
	else
            pc_a = pc_f + 1'b1;
end
assign instruction_f = wb_data_f;
assign i_dat_o = 32'd0;
assign i_we_o =  1'b0;
assign i_sel_o = 4'b1111;
assign i_bte_o =  2'b00;
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        pc_f <= eba_reset_minus_4[ ((32-2)+2-1):2];
        pc_d <= { (32-2){1'b0}};
        pc_x <= { (32-2){1'b0}};
        pc_m <= { (32-2){1'b0}};
        pc_w <= { (32-2){1'b0}};
    end
    else
    begin
        if (stall_f ==  1'b0)
            pc_f <= pc_a;
        if (stall_d ==  1'b0)
            pc_d <= pc_f;
        if (stall_x ==  1'b0)
            pc_x <= pc_d;
        if (stall_m ==  1'b0)
            pc_m <= pc_x;
        pc_w <= pc_m;
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        i_cyc_o <=  1'b0;
        i_stb_o <=  1'b0;
        i_adr_o <= { 32{1'b0}};
        i_cti_o <=  3'b111;
        i_lock_o <=  1'b0;
        wb_data_f <= { 32{1'b0}};
    end
    else
    begin   
        if (i_cyc_o ==  1'b1)
        begin
            if((i_ack_i ==  1'b1) || (i_err_i ==  1'b1))
            begin
                i_cyc_o <=  1'b0;
                i_stb_o <=  1'b0;
                wb_data_f <= i_dat_i;
            end
        end
        else
        begin
            if (   (stall_a ==  1'b0) 
               )
            begin
                i_adr_o <= {pc_a, 2'b00};
                i_cyc_o <=  1'b1;
                i_stb_o <=  1'b1;
            end
	    else
	    begin
	        if (   (stall_a ==  1'b0) 
	           )
		begin
		end
	    end
        end
    end
end
always @(posedge clk_i  )
begin
    if (rst_i ==  1'b1)
    begin
        instruction_d <= { 32{1'b0}};
    end
    else
    begin
        if (stall_d ==  1'b0)
        begin
            instruction_d <= instruction_f;
        end
    end
end  
endmodule
module lm32_interrupt_minimal (
    clk_i, 
    rst_i,
    interrupt,
    stall_x,
    exception,
    eret_q_x,
    csr,
    csr_write_data,
    csr_write_enable,
    interrupt_exception,
    csr_read_data
    );
parameter interrupts =  32;         
input clk_i;                                    
input rst_i;                                    
input [interrupts-1:0] interrupt;               
input stall_x;                                  
input exception;                                
input eret_q_x;                                 
input [ (4 -1):0] csr;                      
input [ (32-1):0] csr_write_data;          
input csr_write_enable;                         
output interrupt_exception;                     
wire   interrupt_exception;
output [ (32-1):0] csr_read_data;          
reg    [ (32-1):0] csr_read_data;
wire [interrupts-1:0] asserted;                 
wire [interrupts-1:0] interrupt_n_exception;
reg ie;                                         
reg eie;                                        
reg [interrupts-1:0] ip;                        
reg [interrupts-1:0] im;                        
assign interrupt_n_exception = ip & im;
assign interrupt_exception = (|interrupt_n_exception) & ie;
assign asserted = ip | interrupt;
generate
    if (interrupts > 1) 
    begin
always @(*)
begin
    case (csr)
     4 'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    1'b0,                                     
                                    eie, 
                                    ie
                                   };
     4 'h2:  csr_read_data = ip;
     4 'h1:  csr_read_data = im;
    default:       csr_read_data = { 32{1'bx}};
    endcase
end
    end
    else
    begin
always @(*)
begin
    case (csr)
     4 'h0:  csr_read_data = {{ 32-3{1'b0}}, 
                                    1'b0,                                    
                                    eie, 
                                    ie
                                   };
     4 'h2:  csr_read_data = ip;
    default:       csr_read_data = { 32{1'bx}};
      endcase
end
    end
endgenerate
   reg [ 10:0] eie_delay  = 0;
generate
    if (interrupts > 1)
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie                   <=  1'b0;
        eie                  <=  1'b0;
        im                   <= {interrupts{1'b0}};
        ip                   <= {interrupts{1'b0}};
       eie_delay             <= 0;
    end
    else
    begin
        ip                   <= asserted;
        if (exception ==  1'b1)
        begin
            eie              <= ie;
            ie               <=  1'b0;
        end
        else if (stall_x ==  1'b0)
        begin
           if(eie_delay[0])
             ie              <= eie;
           eie_delay         <= {1'b0, eie_delay[ 10:1]};
            if (eret_q_x ==  1'b1) begin
               eie_delay[ 10] <=  1'b1;
               eie_delay[ 10-1:0] <= 0;
            end
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  4 'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                end
                if (csr ==  4 'h1)
                    im  <= csr_write_data[interrupts-1:0];
                if (csr ==  4 'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
else
    begin
always @(posedge clk_i  )
  begin
    if (rst_i ==  1'b1)
    begin
        ie              <=  1'b0;
        eie             <=  1'b0;
        ip              <= {interrupts{1'b0}};
       eie_delay        <= 0;
    end
    else
    begin
        ip              <= asserted;
        if (exception ==  1'b1)
        begin
            eie         <= ie;
            ie          <=  1'b0;
        end
        else if (stall_x ==  1'b0)
          begin
             if(eie_delay[0])
               ie              <= eie;
             eie_delay         <= {1'b0, eie_delay[ 10:1]};
             if (eret_q_x ==  1'b1) begin
                eie_delay[ 10] <=  1'b1;
                eie_delay[ 10-1:0] <= 0;
             end
            else if (csr_write_enable ==  1'b1)
            begin
                if (csr ==  4 'h0)
                begin
                    ie  <= csr_write_data[0];
                    eie <= csr_write_data[1];
                end
                if (csr ==  4 'h2)
                    ip  <= asserted & ~csr_write_data[interrupts-1:0];
            end
        end
    end
end
    end
endgenerate
endmodule
