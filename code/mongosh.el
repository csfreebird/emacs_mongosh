(setq db-list '(("db1" . ("user1" "pwd1"))
                ("db2" . ("user2" "pwd2"))
                ("db3" . ("user3" "pwd3"))))

(defun gen-auth-cmd (db_name)
  "生成mongosh中登录数据库的命令, 比如: db.auth('user', pwd')"
  (setq up-list (cdr (assoc db_name db-list)))
  (setq auth-cmd (format "use %s\ndb.auth('%s', '%s')\n" db_name (nth 0 up-list) (nth 1 up-list)))
  auth-cmd
  )

(defun mongosh (db_name)
  "在新的buffer里面运行mongosh客户端"
  (interactive "s请输入数据库名:")
  (let ((buffer-name (concat "*mongo_" db_name "*")))
    (if (get-buffer buffer-name)
        (kill-buffer buffer-name))
    ;; (make-comint-in-buffer "mongosh" buffer-name (concat "mongo_" db_name))
    (make-comint-in-buffer "mongosh" buffer-name "mongosh")
    (switch-to-buffer buffer-name)
    (comint-send-string (get-buffer-process buffer-name) (gen-auth-cmd db_name))))
