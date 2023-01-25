# FEDRELAY API LINKS

### USER

---

| Method    | Route               | Protected | Description                                                   |
| --------- | ------------------- | --------- | ------------------------------------------------------------- |
| POST      | /user/create        | No        | Create an account                                             |
| POST      | /user/login         | No        | Create a login session                                        |
| POST      | /user/logout        | No        | Delete session info                                           |
| GET       | /user/id            | Yes       | Get an user's info (all infos include avatar) based on the id |
| PUT/PATCH | /user/id/avatar     | Yes       | Update user's avatar                                          |
| POST      | /user/id/profil     | Yes       | Create user's profil                                          |
| GET       | /user/id/deliveries | Yes       | Get all the deliveries created by an user                     |
| POST      | /user/id/chat       | Yes       | Create and send a message                                     |
| GET       | /user/id/chat       | Yes       | Get the messages sent by the user                             |

### DELIVERY

---

| Method | Route                    | Protected | Description            |
| ------ | ------------------------ | --------- | ---------------------- |
| POST   | /user/id/delivery/create | Yes       | Create a delivery      |
| GET    | /delivery/id             | Yes       | Get a delivery details |
| POST   | /delivery/followup       | No        | Follow up a delivery   |

### OTHERS

---

| Method | Route        | Protected | Description                   |
| ------ | ------------ | --------- | ----------------------------- |
| POST   | /simulator   | No        | Simulate the price            |
| POST   | /newsletter  | No        | Subscribe to the Newsletter   |
| POST   | /contact     | No        | Contact our customer services |
| POST   | /partnership | No        | Apply for a partnership       |
