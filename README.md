# Mô tả chi tiết thiết lập môi trường:
1.Tải và cài đặt nodejs 
	- Truy cập trang web chính thức của Node.js tại: https://nodejs.org/en/download/package-manager/current.
2.Tải và cài đặt ipfs 
	- Truy cập trang web chính thức https://docs.ipfs.tech/install/command-line/#install-official-binary-distributions.
3.Tải vè cài đặt ganache 
	-Tạo mới : new workspace
	-TRUFFLE PROJECTS -> chọn add Project ->Blockchain-For-EHR-Management/truffle-config.js
	-Server : HOSTNAME :127.0.0.1 ,PORT NUMBER : 7545,NETWORK ID : 5777
	Bấm nút start
4.Cài đặt Metamask
	-Truy cập website :https://metamask.io/
	-Cài đặt MetaMask như một extension trên trình duyệt.
	-Thiết lập môi trường thử nghiệm trên MetaMask:
	-Chuyển sang mạng thử nghiệm (Testnet)
	-Mở MetaMask và nhấn vào "Add Network"
	-Điền thông tin từ Ganache:
		Network Name: Ganache
		New RPC URL: http://127.0.0.1:8545
		Chain ID: 1337 
		Currency Symbol: ETH
	-Lưu và dùng mạng thử nghiệm
5.Cài đặt tài khoản thử nghiệm
	-Chọn môi trường test
	- Chọn thêm tài khoản hoặc ví cứng -> nhập tài khoản -> vào lại ganache -> chọn acount-> 
		chọn 1 account và bấm vào hình khóa -> copy PRIVATE KEY-> dán vào ô -> nhập
		(nếu thành công sẽ hiển thị tài khoản với chung số tiền trong ganache)
6.Chạy web 
	B1: chạy ứng dụng ganache.
	B2: chạy ipfs : mở powershell(với vai trò admin) , chạy câu lệnh ipfs daemon.
	B3: mở file code trên vscode : chạy các câu lệnh 
		+ npm install -force    
		+ npm install -g truffle
		+ truffle mirage --reset
		+ ipfs daemon 
	B4: chạy web trên brower : http://localhost:3000/.
