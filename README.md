# MyNFTERC1155
1155 相較ERC-721提供了.  
同時包含Fungible Token, Non-Fungible Token於一個合約當中.  
批量轉賬: 可單筆交易轉賬多種代幣資產；   
批量查詢餘額：可以單筆查詢多種代幣餘額資料；   
批量授權：可以單筆交易向指定地址授權多種代幣的使用權；   

多出了批次處理的概念在批次操作時Gas的節省上也會有很大的進步.  
同樣看到ERC-1155提供的Function.  
function safeTransferFrom(address _from, address _to, uint256 _id, uint256 _value, bytes calldata _data) external;   
function `safeBatchTransferFrom`(address _from, address _to, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external;  
function balanceOf(address _owner, uint256 _id) external view returns (uint256);  
function `balanceOfBatch`(address[] calldata _owners, uint256[] calldata _ids) external view returns (uint256[] memory);  
function setApprovalForAll(address _operator, bool _approved) external;  
function isApprovedForAll(address _owner, address _operator) external view returns (bool);  
在灰底的Batch操作中資料皆是以陣列方式傳送進來進行處理.  

在看回來本次範例使用的程式碼, 本次繼承ERC1155PresetMinterPauser, 此合約繼承了ERC1155內所有的features.  
其中與上一篇ERC721 setBaseURI不同的部分, 1155這邊直接將uri於constructor中帶入進行設定.  
```Solidity
constructor(string memory uri_) {
        _setURI(uri_);
    }
```
這邊同樣使用pinata進行png, metadata的上傳, 並將網址貼上, {id}中的內容會自動帶入對應點選的tokenID.  
且在mint中設定四個參數(address to,uint256 id,uint256 amount,bytes memory data)其中新增的amount設定為1時, 其屬性就會像ERC721的NFT一樣，只有一個人可以擁有.  
```Solidity
contract myNFT1155 is ERC1155PresetMinterPauser {
    
    uint256 public constant COMMON = 0;
    uint256 public constant RARE = 1;
    uint256 public constant SR = 2;
    uint256 public constant SSR = 3;
    
    constructor() ERC1155PresetMinterPauser( "https://gateway.pinata.cloud/ipfs/QmRoENYamuX58oHPRaCeAsPPxY5Mdk5NS4dwEkTbJoo8Hj/{id}") {
        _mint(msg.sender, COMMON, 10**18, "");
        _mint(msg.sender, SSR, 1, "");
        _mint(msg.sender, RARE, 5, "");
        _mint(msg.sender, SR, 10, "");
    }
    
}
```
contract發布後[EtherScan]([url](https://goerli.etherscan.io/address/0xa4c828dfcbba1a4b40de23c60f0ccad6d44fb7b7)), 就可以在opensea上看到我們mint的NFT啦！   
<img width="723" alt="image" src="https://user-images.githubusercontent.com/24216536/196880374-c62f725e-a144-4888-842f-912ec0db4708.png">   
而1155下最重要的多重數量NFT就在這邊, 可以看到數量為10個對應回稀有度就是SR也就是token id = 2囉。  
![image](https://user-images.githubusercontent.com/24216536/196881978-fe6efd2b-3743-4b4b-852d-3ced44a0a831.png)  

接下來使用一些交易吧。可以看到mint後的數量由10變為12個  
<img width="299" alt="image" src="https://user-images.githubusercontent.com/24216536/196907429-6b04c7fc-43df-45b8-87d0-9351401aeb80.png">  
<img width="904" alt="image" src="https://user-images.githubusercontent.com/24216536/196907303-a8bb7e72-9dad-462f-829e-4fd39a209c79.png">   

用safeBatchTransferFrom來直接轉兩種NFT給其他帳號試試看  
<img width="317" alt="image" src="https://user-images.githubusercontent.com/24216536/196909123-71290891-c154-4fc5-b4e6-d5a4d242f96c.png">.   

成功出現在帳號2的opensea collection中.可以看到有兩個擁有者, 也就是帳號1跟帳號2啦~~~   
<img width="721" alt="image" src="https://user-images.githubusercontent.com/24216536/196909767-6cbf9fb5-a54d-4254-a960-f94fbe09da44.png">.  
<img width="1096" alt="image" src="https://user-images.githubusercontent.com/24216536/196910147-f1e338f1-026f-44ac-a870-9749fb559830.png">.  

假設自己是項目方, 要將NFT銷毀,來試試看Burn, 可以看到總計為5個擁有為4個,一個被銷毀了~.  
<img width="283" alt="image" src="https://user-images.githubusercontent.com/24216536/196910967-82d0d701-2911-43c0-acc8-22d15510ab16.png">.  
<img width="1274" alt="image" src="https://user-images.githubusercontent.com/24216536/196911116-bfdc6ab7-7fd1-4652-a92f-1ac0012038ea.png">.  

ERC1155的部分就練習到這邊嚕









