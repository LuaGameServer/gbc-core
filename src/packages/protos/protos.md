[返回主页](/index.html)
#protobuf定义
```protobuf
syntax = "proto3";
package pb;

message Pack{
	string action = 1;
	bytes content = 2; //actions的参数
	int32 type = 3;
}


```