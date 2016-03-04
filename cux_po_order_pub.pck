CREATE OR REPLACE PACKAGE cux_po_order_pub IS
  /*$Version: CUXPOODR.pls 12.1.3 2016-03-01 18:10:00 Jim ship $*/
  /*==========================================================================+
  |             Copyright (c) 2016  HAND All rights reserved.                 |
  +===========================================================================+
  |  Program Name : CUX_PO_ORDER_PUB                                          |
  |  Description  : 采购订单工作台关于订单审批工作流程相关操作                |
  |                                                                           |
  |   History :                                                               |
  |        2016-03-01  XXXXXXXX@HAND  created new package                     |
  +==========================================================================*/

  /*==================================================
  --Procedure/Function Name : submit_order_main
  --Description ：采购员提交采购订单以审批
  --Argument : p_api_version   : Api Version : Default value = 1.0
               p_init_msg_list : Initialize the message queue : True/False
               p_commit        : Commit : True/False
               x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
               p_po_header_id  : 订单标识
  --History：1.00  2016-03-01  XXXXXX  Creation
  ==================================================*/
  PROCEDURE submit_order_main(p_api_version   IN NUMBER DEFAULT 1.0,
                              p_init_msg_list IN VARCHAR2 DEFAULT fnd_api.g_false,
                              p_commit        IN VARCHAR2 DEFAULT fnd_api.g_false,
                              x_return_status OUT NOCOPY VARCHAR2,
                              x_msg_count     OUT NOCOPY NUMBER,
                              x_msg_data      OUT NOCOPY VARCHAR2,
                              p_po_header_id  IN NUMBER);
  /*==================================================
  --Procedure/Function Name : approve_order_main
  --Description ：审批采购订单-存在两种结果：审批通过、审批拒绝
  --Argument : p_api_version   : Api Version : Default value = 1.0
               p_init_msg_list : Initialize the message queue : True/False
               p_commit        : Commit : True/False
               x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
               p_po_header_id  : 订单标识
               p_result_code   : 审批结果代码：审批通过(APPROVED)/审批拒绝(REJECTED)
  --History：1.00  2016-03-01  XXXXXX  Creation
  ==================================================*/
  /*PROCEDURE approve_order_main(p_api_version   IN NUMBER DEFAULT 1.0,
                               p_init_msg_list IN VARCHAR2 DEFAULT fnd_api.g_false,
                               p_commit        IN VARCHAR2 DEFAULT fnd_api.g_false,
                               x_return_status OUT NOCOPY VARCHAR2,
                               x_msg_count     OUT NOCOPY NUMBER,
                               x_msg_data      OUT NOCOPY VARCHAR2,
                               p_po_header_id  IN NUMBER,
                               p_result_code   IN VARCHAR2);
  \*==================================================
  --Procedure/Function Name : close_order_main
  --Description ：订单全部流程走完后进行采购订单关闭
  --Argument : p_api_version   : Api Version : Default value = 1.0
               p_init_msg_list : Initialize the message queue : True/False
               p_commit        : Commit : True/False
               x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
               p_po_header_id  : 订单标识
  --History：1.00  2016-03-01  XXXXXX  Creation
  ==================================================*\
  PROCEDURE close_order_main(p_api_version   IN NUMBER DEFAULT 1.0,
                             p_init_msg_list IN VARCHAR2 DEFAULT fnd_api.g_false,
                             p_commit        IN VARCHAR2 DEFAULT fnd_api.g_false,
                             x_return_status OUT NOCOPY VARCHAR2,
                             x_msg_count     OUT NOCOPY NUMBER,
                             x_msg_data      OUT NOCOPY VARCHAR2,
                             p_po_header_id  IN NUMBER);
  \*==================================================
  --Procedure/Function Name : cancel_order_main
  --Description ：后决定无需进行采购或更改采购订单而进行的采购订单取消
  --Argument : p_api_version   : Api Version : Default value = 1.0
               p_init_msg_list : Initialize the message queue : True/False
               p_commit        : Commit : True/False
               x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
               p_po_header_id  : 订单标识
  --History：1.00  2016-03-01  XXXXXX  Creation
  ==================================================*\
  PROCEDURE cancel_order_main(p_api_version   IN NUMBER DEFAULT 1.0,
                              p_init_msg_list IN VARCHAR2 DEFAULT fnd_api.g_false,
                              p_commit        IN VARCHAR2 DEFAULT fnd_api.g_false,
                              x_return_status OUT NOCOPY VARCHAR2,
                              x_msg_count     OUT NOCOPY NUMBER,
                              x_msg_data      OUT NOCOPY VARCHAR2,
                              p_po_header_id  IN NUMBER);*/
END cux_po_order_pub;
/
CREATE OR REPLACE PACKAGE BODY cux_po_order_pub IS
  /*==================================================
  Copyright (C) Hand Enterprise Solutions Co.,Ltd.
             AllRights Reserved
  ==================================================*/

  -- Global variable
  g_pkg_name CONSTANT VARCHAR2(30) := 'CUX_PO_ORDER_PUB';
  g_po_header_id   NUMBER;
  g_po_headers_rec cux_po_headers%ROWTYPE;

  /*==================================================
  --Procedure/Function Name : raise_exception
  --Description ：判断当状态为 E 或 U 时抛出例外
  --Argument : x_return_status : Input Status : E(Error)/U(Unexception)/S(Success)
  --History：1.00  2016-03-01  XXXXXX  Creation
  ==================================================*/
  PROCEDURE raise_exception(x_return_status IN VARCHAR2) IS
  BEGIN
    IF (x_return_status = fnd_api.g_ret_sts_unexp_error) THEN
      RAISE fnd_api.g_exc_unexpected_error;
    ELSIF (x_return_status = fnd_api.g_ret_sts_error) THEN
      RAISE fnd_api.g_exc_error;
    END IF;
  END raise_exception;
  /*==================================================
  --Procedure/Function Name : lock_record
  --Description ：1、锁定数据
  --Argument : x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
  --History：1.00  2016-03-01  XXXXXX  Creation
  ==================================================*/
  PROCEDURE lock_record(x_return_status OUT NOCOPY VARCHAR2,
                        x_msg_count     OUT NOCOPY NUMBER,
                        x_msg_data      OUT NOCOPY VARCHAR2) IS
    l_api_name CONSTANT VARCHAR2(30) := 'lock_record';
    l_savepoint_name VARCHAR2(30) := '';
    l_error_flag     BOOLEAN;
  BEGIN
    --程序开始
    x_return_status := hss_api.start_activity(p_pkg_name       => g_pkg_name,
                                              p_api_name       => l_api_name,
                                              p_savepoint_name => l_savepoint_name,
                                              p_init_msg_list  => fnd_api.g_false);
  
    BEGIN
      SELECT cph.*
        INTO g_po_headers_rec
        FROM cux_po_headers cph
       WHERE cph.header_id = g_po_header_id
         FOR UPDATE NOWAIT;
    EXCEPTION
      WHEN no_data_found THEN
        l_error_flag := TRUE;
        hss_api.set_message(p_app_name     => 'CUX',
                            p_msg_name     => 'CUX_PO_ID_CANNOT_IDENTIFY_PO',
                            p_token1       => 'PO_HEADER_ID',
                            p_token1_value => g_po_header_id);
      WHEN OTHERS THEN
        l_error_flag := TRUE;
        hss_api.set_message(p_app_name     => 'FND',
                            p_msg_name     => 'FND_LOCK_RECORD_ERROR',
                            p_token1       => 'ID',
                            p_token1_value => g_po_header_id,
                            p_token2       => 'SQLERR',
                            p_token2_value => 'CUX_PO_HEADERS ' || SQLERRM);
    END;
  
    IF l_error_flag THEN
      x_return_status := fnd_api.g_ret_sts_error;
      raise_exception(x_return_status);
    END IF;
    --程序结束
    x_return_status := hss_api.end_activity(p_pkg_name  => g_pkg_name,
                                            p_api_name  => l_api_name,
                                            p_commit    => fnd_api.g_false,
                                            x_msg_count => x_msg_count,
                                            x_msg_data  => x_msg_data);
  
  EXCEPTION
    WHEN fnd_api.g_exc_error THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_error,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
    
    WHEN fnd_api.g_exc_unexpected_error THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_unexp,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
    WHEN OTHERS THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_others,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
  END lock_record;
  /*==================================================
  --Procedure/Function Name : validate_submit_data
  --Description ：2、验证提交记录
                    (1) 订单状态必须为新建或已拒绝状态
  --Argument : x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
  --History：1.00  2016-03-01  XXXXXX  Creation
  ==================================================*/
  PROCEDURE validate_submit_data(x_return_status OUT NOCOPY VARCHAR2,
                                 x_msg_count     OUT NOCOPY NUMBER,
                                 x_msg_data      OUT NOCOPY VARCHAR2) IS
    l_api_name CONSTANT VARCHAR2(30) := 'validate_submit_data';
    l_savepoint_name VARCHAR2(30) := '';
  
    l_error_flag BOOLEAN;
  BEGIN
    --程序开始
    x_return_status := hss_api.start_activity(p_pkg_name       => g_pkg_name,
                                              p_api_name       => l_api_name,
                                              p_savepoint_name => l_savepoint_name,
                                              p_init_msg_list  => fnd_api.g_false);
    --(1) 订单状态必须为新建或已拒绝状态-------------------------
    IF nvl(g_po_headers_rec.order_status,
           'NEW') NOT IN ('NEW',
                          'REJECTED') THEN
      l_error_flag := TRUE;
      hss_api.set_message(p_app_name     => 'CUX',
                          p_msg_name     => 'CUX_PO_SUBMIT_STATUS_ERROR',
                          p_token1       => 'PO_NUMBER',
                          p_token1_value => g_po_headers_rec.order_number);
    END IF;
  
    IF l_error_flag THEN
      x_return_status := fnd_api.g_ret_sts_error;
      raise_exception(x_return_status);
    END IF;
    --程序结束
    x_return_status := hss_api.end_activity(p_pkg_name  => g_pkg_name,
                                            p_api_name  => l_api_name,
                                            p_commit    => fnd_api.g_false,
                                            x_msg_count => x_msg_count,
                                            x_msg_data  => x_msg_data);
  
  EXCEPTION
    WHEN fnd_api.g_exc_error THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_error,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
    
    WHEN fnd_api.g_exc_unexpected_error THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_unexp,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
    WHEN OTHERS THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_others,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
  END validate_submit_data;
  /*==================================================
  --Procedure/Function Name : update_bill_status
  --Description ：根据传入状态以更新至订单头上
  --Argument : x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
  --History：1.00  2016-03-01  XXXXXX  Creation
  ==================================================*/
  PROCEDURE update_order_status(x_return_status OUT NOCOPY VARCHAR2,
                                x_msg_count     OUT NOCOPY NUMBER,
                                x_msg_data      OUT NOCOPY VARCHAR2,
                                p_po_header_id  IN NUMBER,
                                p_status_code   IN VARCHAR2) IS
    l_api_name CONSTANT VARCHAR2(30) := 'update_bill_status';
    l_savepoint_name VARCHAR2(30) := '';
  BEGIN
    --程序开始
    x_return_status := hss_api.start_activity(p_pkg_name       => g_pkg_name,
                                              p_api_name       => l_api_name,
                                              p_savepoint_name => l_savepoint_name,
                                              p_init_msg_list  => fnd_api.g_false);
  
    UPDATE cux_po_headers cph
       SET cph.order_status      = p_status_code,
           cph.last_updated_by   = fnd_global.user_id,
           cph.last_update_date  = SYSDATE,
           cph.last_update_login = fnd_global.login_id
     WHERE cph.header_id = p_po_header_id;
    --程序结束
    x_return_status := hss_api.end_activity(p_pkg_name  => g_pkg_name,
                                            p_api_name  => l_api_name,
                                            p_commit    => fnd_api.g_false,
                                            x_msg_count => x_msg_count,
                                            x_msg_data  => x_msg_data);
  
  EXCEPTION
    WHEN fnd_api.g_exc_error THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_error,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
    
    WHEN fnd_api.g_exc_unexpected_error THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_unexp,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
    WHEN OTHERS THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_others,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
  END update_order_status;
  /*==================================================
  --Procedure/Function Name : process_submit
  --Description ：3、处理提交流程
                    (1) 更新订单状态为已提交
  --Argument : x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
  --History：1.00  2016-03-01  XXXXXX  Creation
  ==================================================*/
  PROCEDURE process_submit(x_return_status OUT NOCOPY VARCHAR2,
                           x_msg_count     OUT NOCOPY NUMBER,
                           x_msg_data      OUT NOCOPY VARCHAR2) IS
    l_api_name CONSTANT VARCHAR2(30) := 'process_submit';
    l_savepoint_name VARCHAR2(30) := '';
  BEGIN
    --程序开始
    x_return_status := hss_api.start_activity(p_pkg_name       => g_pkg_name,
                                              p_api_name       => l_api_name,
                                              p_savepoint_name => l_savepoint_name,
                                              p_init_msg_list  => fnd_api.g_false);
    --(1) 更新订单状态为已提交-------------------------------------
    update_order_status(x_return_status,
                        x_msg_count,
                        x_msg_data,
                        g_po_headers_rec.header_id,
                        'SUBMITTED');
    raise_exception(x_return_status);
    --程序结束
    x_return_status := hss_api.end_activity(p_pkg_name  => g_pkg_name,
                                            p_api_name  => l_api_name,
                                            p_commit    => fnd_api.g_false,
                                            x_msg_count => x_msg_count,
                                            x_msg_data  => x_msg_data);
  
  EXCEPTION
    WHEN fnd_api.g_exc_error THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_error,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
    
    WHEN fnd_api.g_exc_unexpected_error THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_unexp,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
    WHEN OTHERS THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_others,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
  END process_submit;
  /*==================================================
  --Procedure/Function Name : submit_order_main
  --Description ：采购员提交采购订单以审批
                     1、锁定记录
                     2、验证提交记录
                     3、处理提交流程
  --History：1.00  2016-03-01  XXXXXX  Creation
  ==================================================*/
  PROCEDURE submit_order_main(p_api_version   IN NUMBER DEFAULT 1.0,
                              p_init_msg_list IN VARCHAR2 DEFAULT fnd_api.g_false,
                              p_commit        IN VARCHAR2 DEFAULT fnd_api.g_false,
                              x_return_status OUT NOCOPY VARCHAR2,
                              x_msg_count     OUT NOCOPY NUMBER,
                              x_msg_data      OUT NOCOPY VARCHAR2,
                              p_po_header_id  IN NUMBER) IS
    l_api_name       CONSTANT VARCHAR2(30) := 'submit_order_main';
    l_savepoint_name CONSTANT VARCHAR2(30) := 'submit_order_main01';
  
  BEGIN
    --程序开始
    x_return_status  := hss_api.start_activity(p_pkg_name       => g_pkg_name,
                                               p_api_name       => l_api_name,
                                               p_savepoint_name => l_savepoint_name,
                                               p_init_msg_list  => p_init_msg_list,
                                               p_api_version    => p_api_version);
    g_po_header_id   := p_po_header_id;
    g_po_headers_rec := NULL;
  
    --1、锁定记录---------------------------------------
    lock_record(x_return_status,
                x_msg_count,
                x_msg_data);
    raise_exception(x_return_status);
  
    --2、验证提交记录-----------------------------------
    validate_submit_data(x_return_status,
                         x_msg_count,
                         x_msg_data);
    raise_exception(x_return_status);
  
    --3、处理提交流程-----------------------------------
    process_submit(x_return_status,
                   x_msg_count,
                   x_msg_data);
    raise_exception(x_return_status);
  
    --程序结束
    x_return_status := hss_api.end_activity(p_pkg_name  => g_pkg_name,
                                            p_api_name  => l_api_name,
                                            p_commit    => p_commit,
                                            x_msg_count => x_msg_count,
                                            x_msg_data  => x_msg_data);
  
  EXCEPTION
    WHEN fnd_api.g_exc_error THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_error,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
    
    WHEN fnd_api.g_exc_unexpected_error THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_unexp,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
    
    WHEN OTHERS THEN
      x_return_status := hss_api.handle_exceptions(p_pkg_name       => g_pkg_name,
                                                   p_api_name       => l_api_name,
                                                   p_savepoint_name => l_savepoint_name,
                                                   p_exc_name       => hss_api.g_exc_name_others,
                                                   x_msg_count      => x_msg_count,
                                                   x_msg_data       => x_msg_data);
  END submit_order_main;
END cux_po_order_pub;
/
