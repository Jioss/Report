CREATE OR REPLACE PACKAGE cux_po_order_pub IS
  /*$Version: CUXPOODR.pls 12.1.3 2016-03-01 18:10:00 Jim ship $*/
  /*==========================================================================+
  |             Copyright (c) 2016  HAND All rights reserved.                 |
  +===========================================================================+
  |  Program Name : CUX_PO_ORDER_PUB                                          |
  |  Description  : �ɹ���������̨���ڶ�����������������ز���                |
  |                                                                           |
  |   History :                                                               |
  |        2016-03-01  XXXXXXXX@HAND  created new package                     |
  +==========================================================================*/

  /*==================================================
  --Procedure/Function Name : submit_order_main
  --Description ���ɹ�Ա�ύ�ɹ�����������
  --Argument : p_api_version   : Api Version : Default value = 1.0
               p_init_msg_list : Initialize the message queue : True/False
               p_commit        : Commit : True/False
               x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
               p_po_header_id  : ������ʶ
  --History��1.00  2016-03-01  XXXXXX  Creation
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
  --Description �������ɹ�����-�������ֽ��������ͨ���������ܾ�
  --Argument : p_api_version   : Api Version : Default value = 1.0
               p_init_msg_list : Initialize the message queue : True/False
               p_commit        : Commit : True/False
               x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
               p_po_header_id  : ������ʶ
               p_result_code   : ����������룺����ͨ��(APPROVED)/�����ܾ�(REJECTED)
  --History��1.00  2016-03-01  XXXXXX  Creation
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
  --Description ������ȫ�������������вɹ������ر�
  --Argument : p_api_version   : Api Version : Default value = 1.0
               p_init_msg_list : Initialize the message queue : True/False
               p_commit        : Commit : True/False
               x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
               p_po_header_id  : ������ʶ
  --History��1.00  2016-03-01  XXXXXX  Creation
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
  --Description �������������вɹ�����Ĳɹ����������еĲɹ�����ȡ��
  --Argument : p_api_version   : Api Version : Default value = 1.0
               p_init_msg_list : Initialize the message queue : True/False
               p_commit        : Commit : True/False
               x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
               p_po_header_id  : ������ʶ
  --History��1.00  2016-03-01  XXXXXX  Creation
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
  --Description ���жϵ�״̬Ϊ E �� U ʱ�׳�����
  --Argument : x_return_status : Input Status : E(Error)/U(Unexception)/S(Success)
  --History��1.00  2016-03-01  XXXXXX  Creation
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
  --Description ��1����������
  --Argument : x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
  --History��1.00  2016-03-01  XXXXXX  Creation
  ==================================================*/
  PROCEDURE lock_record(x_return_status OUT NOCOPY VARCHAR2,
                        x_msg_count     OUT NOCOPY NUMBER,
                        x_msg_data      OUT NOCOPY VARCHAR2) IS
    l_api_name CONSTANT VARCHAR2(30) := 'lock_record';
    l_savepoint_name VARCHAR2(30) := '';
    l_error_flag     BOOLEAN;
  BEGIN
    --����ʼ
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
    --�������
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
  --Description ��2����֤�ύ��¼
                    (1) ����״̬����Ϊ�½����Ѿܾ�״̬
  --Argument : x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
  --History��1.00  2016-03-01  XXXXXX  Creation
  ==================================================*/
  PROCEDURE validate_submit_data(x_return_status OUT NOCOPY VARCHAR2,
                                 x_msg_count     OUT NOCOPY NUMBER,
                                 x_msg_data      OUT NOCOPY VARCHAR2) IS
    l_api_name CONSTANT VARCHAR2(30) := 'validate_submit_data';
    l_savepoint_name VARCHAR2(30) := '';
  
    l_error_flag BOOLEAN;
  BEGIN
    --����ʼ
    x_return_status := hss_api.start_activity(p_pkg_name       => g_pkg_name,
                                              p_api_name       => l_api_name,
                                              p_savepoint_name => l_savepoint_name,
                                              p_init_msg_list  => fnd_api.g_false);
    --(1) ����״̬����Ϊ�½����Ѿܾ�״̬-------------------------
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
    --�������
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
  --Description �����ݴ���״̬�Ը���������ͷ��
  --Argument : x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
  --History��1.00  2016-03-01  XXXXXX  Creation
  ==================================================*/
  PROCEDURE update_order_status(x_return_status OUT NOCOPY VARCHAR2,
                                x_msg_count     OUT NOCOPY NUMBER,
                                x_msg_data      OUT NOCOPY VARCHAR2,
                                p_po_header_id  IN NUMBER,
                                p_status_code   IN VARCHAR2) IS
    l_api_name CONSTANT VARCHAR2(30) := 'update_bill_status';
    l_savepoint_name VARCHAR2(30) := '';
  BEGIN
    --����ʼ
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
    --�������
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
  --Description ��3�������ύ����
                    (1) ���¶���״̬Ϊ���ύ
  --Argument : x_return_status : Return Status : E(Error)/U(Unexception)/S(Success)
               x_msg_count     : Messages Count
               x_msg_data      : Error Or Unexception Message
  --History��1.00  2016-03-01  XXXXXX  Creation
  ==================================================*/
  PROCEDURE process_submit(x_return_status OUT NOCOPY VARCHAR2,
                           x_msg_count     OUT NOCOPY NUMBER,
                           x_msg_data      OUT NOCOPY VARCHAR2) IS
    l_api_name CONSTANT VARCHAR2(30) := 'process_submit';
    l_savepoint_name VARCHAR2(30) := '';
  BEGIN
    --����ʼ
    x_return_status := hss_api.start_activity(p_pkg_name       => g_pkg_name,
                                              p_api_name       => l_api_name,
                                              p_savepoint_name => l_savepoint_name,
                                              p_init_msg_list  => fnd_api.g_false);
    --(1) ���¶���״̬Ϊ���ύ-------------------------------------
    update_order_status(x_return_status,
                        x_msg_count,
                        x_msg_data,
                        g_po_headers_rec.header_id,
                        'SUBMITTED');
    raise_exception(x_return_status);
    --�������
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
  --Description ���ɹ�Ա�ύ�ɹ�����������
                     1��������¼
                     2����֤�ύ��¼
                     3�������ύ����
  --History��1.00  2016-03-01  XXXXXX  Creation
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
    --����ʼ
    x_return_status  := hss_api.start_activity(p_pkg_name       => g_pkg_name,
                                               p_api_name       => l_api_name,
                                               p_savepoint_name => l_savepoint_name,
                                               p_init_msg_list  => p_init_msg_list,
                                               p_api_version    => p_api_version);
    g_po_header_id   := p_po_header_id;
    g_po_headers_rec := NULL;
  
    --1��������¼---------------------------------------
    lock_record(x_return_status,
                x_msg_count,
                x_msg_data);
    raise_exception(x_return_status);
  
    --2����֤�ύ��¼-----------------------------------
    validate_submit_data(x_return_status,
                         x_msg_count,
                         x_msg_data);
    raise_exception(x_return_status);
  
    --3�������ύ����-----------------------------------
    process_submit(x_return_status,
                   x_msg_count,
                   x_msg_data);
    raise_exception(x_return_status);
  
    --�������
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
