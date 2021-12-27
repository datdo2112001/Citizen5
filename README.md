# CitizenV
## Phần mềm quản lý dân số

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

Phần mềm tích hợp cho phép quản lý người dân
- Biểu đồ dễ dàng cho việc quản lý thông tin người dân
- Nhanh chóng trong việc tạo và xem thông tin
- ✨Đơn giản và tiện dụng

## Features

- Xem biểu đồ số liệu người dân;
- Chức năng tạo tài khoản, quản lý tài khoản người dùng;
- Xem danh sách thông tin cụ thể người dân;
- Thêm người dân để quản lý;
- Điều tra tiến độ hoàn thành của các tỉnh, thành phố;

## Tech

- [Ruby on Rails] - framework
- [Bootstrap 3]
- [jQuery]


## Installation

Để cài đặt, đầu tiên, máy cần đạt yêu cầu đã cài Ruby và Rails, đã clone project từ github.
Sau đó, chạy các bước sau:

- Cài đặt các Dependency
```sh
yarn íntall
bundle install
```

- Cần chắc chắn mình đã có mysqlite3 - database phù hợp
- Tạo database
```sh
rake db:create
```

- Và cuối cùng, chạy phần mềm trên local
```sh
rails s
```

For production environments...

```sh
npm install --production
NODE_ENV=production node app
```

## Development

## License
