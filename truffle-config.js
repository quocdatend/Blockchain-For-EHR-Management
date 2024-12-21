module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",     // Localhost (mặc định: không có)
      port: 8545,            // Cổng Ethereum chuẩn (mặc định: không có)
      network_id: "5777",     // Mạng nào cũng được (mặc định: không có)
    },
  },

  mocha: {
    // timeout: 100000
  },

  // Cấu hình biên dịch
  compilers: {
    solc: {
      version: "0.5.1",    // Lấy đúng phiên bản từ solc-bin (mặc định: phiên bản của Truffle)
      settings: {
        optimizer: {
          enabled: true,   // Bật tối ưu hóa
          runs: 200        // Điều chỉnh số lần chạy tối ưu hóa (giảm số lần nếu cần)
        }
      }
    }
  },

  db: {
    enabled: false
  }
};
