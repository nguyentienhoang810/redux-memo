2019/4/8
first redux memo:
only tap to button to add more text

- Khi có 1 event được dispatch từ View, sẽ tạo ra một Action mô tả về event đó.
- Action sẽ được gửi đến Reducer xử lý.
- Reducer sẽ nhận Action và dưạ vào các mô tả của Action để tạo ra một State mới và lưu tại Store.
- Các ViewController đã được subcriber đến Store sẽ nhận được sự thay đổi và tiến hành update UI.
