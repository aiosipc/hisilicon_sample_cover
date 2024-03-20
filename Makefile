CC = /opt/cortex_a7_thumb2-gcc12-musl-4_9/bin/arm-linux-gcc
#INC = -I ../hi3516dv300-rtsp-h264/include -I ../oncam-ui-c/venc/sdk/gk7205v300/include -I ../oncam-ui-c/venc/src
#INC = -I ../oncam-ui-c/venc/sdk/gk7205v300/include -I ../oncam-ui-c/venc/sdk/hi3536dv100/include -I ../oncam-ui-c/venc/src
INC = -I ../oncam-ui-c/venc/sdk/gk7205v300/include -I ../oncam-ui-c/venc/src -I ../oncam-ui-c/venc/sdk
#DEF = -DSENSOR0_TYPE=SONY_IMX335_MIPI_5M_30FPS_12BIT -DSENSOR1_TYPE=SONY_IMX327_MIPI_2M_30FPS_12BIT
DEF = -DSENSOR0_TYPE=SONY_IMX335_MIPI_5M_30FPS_10BIT_WDR2TO1 -DSENSOR1_TYPE=SONY_IMX327_MIPI_2M_30FPS_12BIT
#DEF = -DSENSOR0_TYPE=SONY_IMX307_MIPI_2M_30FPS_12BIT -DSENSOR1_TYPE=SONY_IMX327_MIPI_2M_30FPS_12BIT
LIB = -L ../oncam-ui-c/venc/lib/gk7205v200 -lhi_mpi -lhi_isp -lhi_ae -lhi_awb -lgk_api -lgk_isp -lgk_ae -lgk_awb -ldehaze -ldrc -lldci -lir_auto -ldnvqe -lupvqe -lvoice_engine -lsecurec -lgk_md -lgk_ive -lhi_md -lhi_ive
all:
	$(CC) ../oncam-ui-c/venc/sdk/gk7205v300/sensor/imx307_2l_cmos.c -c -o imx307_2l_cmos.o $(INC)
	$(CC) ../oncam-ui-c/venc/sdk/gk7205v300/sensor/imx307_2l_sensor_ctl.c -c -o imx307_2l_sensor_ctl.o $(INC)
	$(CC) ../oncam-ui-c/venc/sdk/gk7205v300/sensor/imx335_cmos.c -c -o imx335_cmos.o $(INC)
	$(CC) ../oncam-ui-c/venc/sdk/gk7205v300/sensor/imx335_sensor_ctl.c -c -o imx335_sensor_ctl.o $(INC)
	$(CC) ../hi3516dv300-rtsp-h264/sample_comm_isp.c -c -o sample_comm_isp.o $(INC) $(DEF) -DAISA_EXTENSION
	$(CC) ../hi3516dv300-rtsp-h264/sample_comm_sys.c -c -o sample_comm_sys.o $(INC) -DAISA_EXTENSION
	$(CC) ../hi3516dv300-rtsp-h264/sample_comm_vi.c -c -o sample_comm_vi.o $(INC) $(DEF) -DAISA_EXTENSION
	$(CC) ../hi3516dv300-rtsp-h264/sample_comm_vo.c -c -o sample_comm_vo.o $(INC) -DAISA_EXTENSION
	$(CC) ../oncam-ui-c/venc/src/compat.c -c -o compat.o $(INC)
	$(CC) ../oncam-ui-c/venc/src/hierrors.c -c -o hierrors.o $(INC)
	$(CC) ../oncam-ui-c/venc/src/debug_print.c -c -o debug_print.o $(INC)
	$(CC) sample.c -c -o sample.o $(INC) -DAISA_EXTENSION
	$(CC) sample.o sample_comm_isp.o sample_comm_sys.o sample_comm_vi.o sample_comm_vo.o imx307_2l_cmos.o imx307_2l_sensor_ctl.o imx335_cmos.o imx335_sensor_ctl.o compat.o hierrors.o debug_print.o -o sample $(LIB)
