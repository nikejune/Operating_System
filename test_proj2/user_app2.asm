
_user_app2:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"
    
int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 14             	sub    $0x14,%esp

    int i,j;
    int pid = fork();
  11:	e8 ef 02 00 00       	call   305 <fork>
  16:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid<0)
  19:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  1d:	79 14                	jns    33 <main+0x33>
    {
        printf(1,"error\n");
  1f:	83 ec 08             	sub    $0x8,%esp
  22:	68 79 08 00 00       	push   $0x879
  27:	6a 01                	push   $0x1
  29:	e8 7f 04 00 00       	call   4ad <printf>
  2e:	83 c4 10             	add    $0x10,%esp
  31:	eb 6d                	jmp    a0 <main+0xa0>
    }
    else if(pid==0)
  33:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  37:	75 32                	jne    6b <main+0x6b>
    {
       for(i=0;i<100;i++){
  39:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  40:	eb 21                	jmp    63 <main+0x63>
        printf(1,"child %d \n",getlev());
  42:	e8 76 03 00 00       	call   3bd <getlev>
  47:	83 ec 04             	sub    $0x4,%esp
  4a:	50                   	push   %eax
  4b:	68 80 08 00 00       	push   $0x880
  50:	6a 01                	push   $0x1
  52:	e8 56 04 00 00       	call   4ad <printf>
  57:	83 c4 10             	add    $0x10,%esp
        yield();
  5a:	e8 56 03 00 00       	call   3b5 <yield>
    {
        printf(1,"error\n");
    }
    else if(pid==0)
    {
       for(i=0;i<100;i++){
  5f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  63:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  67:	7e d9                	jle    42 <main+0x42>
  69:	eb 35                	jmp    a0 <main+0xa0>
       }
    }
    else
    {
        
        for(j=0;j<100;j++){
  6b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  72:	eb 21                	jmp    95 <main+0x95>
        printf(1,"parent %d \n ",getlev());
  74:	e8 44 03 00 00       	call   3bd <getlev>
  79:	83 ec 04             	sub    $0x4,%esp
  7c:	50                   	push   %eax
  7d:	68 8b 08 00 00       	push   $0x88b
  82:	6a 01                	push   $0x1
  84:	e8 24 04 00 00       	call   4ad <printf>
  89:	83 c4 10             	add    $0x10,%esp
        yield();
  8c:	e8 24 03 00 00       	call   3b5 <yield>
       }
    }
    else
    {
        
        for(j=0;j<100;j++){
  91:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  95:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  99:	7e d9                	jle    74 <main+0x74>
        printf(1,"parent %d \n ",getlev());
        yield();
        }
        wait();
  9b:	e8 75 02 00 00       	call   315 <wait>

    }
    exit();
  a0:	e8 68 02 00 00       	call   30d <exit>

000000a5 <stosb>:
  a5:	55                   	push   %ebp
  a6:	89 e5                	mov    %esp,%ebp
  a8:	57                   	push   %edi
  a9:	53                   	push   %ebx
  aa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ad:	8b 55 10             	mov    0x10(%ebp),%edx
  b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  b3:	89 cb                	mov    %ecx,%ebx
  b5:	89 df                	mov    %ebx,%edi
  b7:	89 d1                	mov    %edx,%ecx
  b9:	fc                   	cld    
  ba:	f3 aa                	rep stos %al,%es:(%edi)
  bc:	89 ca                	mov    %ecx,%edx
  be:	89 fb                	mov    %edi,%ebx
  c0:	89 5d 08             	mov    %ebx,0x8(%ebp)
  c3:	89 55 10             	mov    %edx,0x10(%ebp)
  c6:	5b                   	pop    %ebx
  c7:	5f                   	pop    %edi
  c8:	5d                   	pop    %ebp
  c9:	c3                   	ret    

000000ca <strcpy>:
  ca:	55                   	push   %ebp
  cb:	89 e5                	mov    %esp,%ebp
  cd:	83 ec 10             	sub    $0x10,%esp
  d0:	8b 45 08             	mov    0x8(%ebp),%eax
  d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d6:	90                   	nop
  d7:	8b 45 08             	mov    0x8(%ebp),%eax
  da:	8d 50 01             	lea    0x1(%eax),%edx
  dd:	89 55 08             	mov    %edx,0x8(%ebp)
  e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  e3:	8d 4a 01             	lea    0x1(%edx),%ecx
  e6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  e9:	0f b6 12             	movzbl (%edx),%edx
  ec:	88 10                	mov    %dl,(%eax)
  ee:	0f b6 00             	movzbl (%eax),%eax
  f1:	84 c0                	test   %al,%al
  f3:	75 e2                	jne    d7 <strcpy+0xd>
  f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  f8:	c9                   	leave  
  f9:	c3                   	ret    

000000fa <strcmp>:
  fa:	55                   	push   %ebp
  fb:	89 e5                	mov    %esp,%ebp
  fd:	eb 08                	jmp    107 <strcmp+0xd>
  ff:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 103:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 107:	8b 45 08             	mov    0x8(%ebp),%eax
 10a:	0f b6 00             	movzbl (%eax),%eax
 10d:	84 c0                	test   %al,%al
 10f:	74 10                	je     121 <strcmp+0x27>
 111:	8b 45 08             	mov    0x8(%ebp),%eax
 114:	0f b6 10             	movzbl (%eax),%edx
 117:	8b 45 0c             	mov    0xc(%ebp),%eax
 11a:	0f b6 00             	movzbl (%eax),%eax
 11d:	38 c2                	cmp    %al,%dl
 11f:	74 de                	je     ff <strcmp+0x5>
 121:	8b 45 08             	mov    0x8(%ebp),%eax
 124:	0f b6 00             	movzbl (%eax),%eax
 127:	0f b6 d0             	movzbl %al,%edx
 12a:	8b 45 0c             	mov    0xc(%ebp),%eax
 12d:	0f b6 00             	movzbl (%eax),%eax
 130:	0f b6 c0             	movzbl %al,%eax
 133:	29 c2                	sub    %eax,%edx
 135:	89 d0                	mov    %edx,%eax
 137:	5d                   	pop    %ebp
 138:	c3                   	ret    

00000139 <strlen>:
 139:	55                   	push   %ebp
 13a:	89 e5                	mov    %esp,%ebp
 13c:	83 ec 10             	sub    $0x10,%esp
 13f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 146:	eb 04                	jmp    14c <strlen+0x13>
 148:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 14c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 14f:	8b 45 08             	mov    0x8(%ebp),%eax
 152:	01 d0                	add    %edx,%eax
 154:	0f b6 00             	movzbl (%eax),%eax
 157:	84 c0                	test   %al,%al
 159:	75 ed                	jne    148 <strlen+0xf>
 15b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 15e:	c9                   	leave  
 15f:	c3                   	ret    

00000160 <memset>:
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	83 ec 0c             	sub    $0xc,%esp
 166:	8b 45 10             	mov    0x10(%ebp),%eax
 169:	89 44 24 08          	mov    %eax,0x8(%esp)
 16d:	8b 45 0c             	mov    0xc(%ebp),%eax
 170:	89 44 24 04          	mov    %eax,0x4(%esp)
 174:	8b 45 08             	mov    0x8(%ebp),%eax
 177:	89 04 24             	mov    %eax,(%esp)
 17a:	e8 26 ff ff ff       	call   a5 <stosb>
 17f:	8b 45 08             	mov    0x8(%ebp),%eax
 182:	c9                   	leave  
 183:	c3                   	ret    

00000184 <strchr>:
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	83 ec 04             	sub    $0x4,%esp
 18a:	8b 45 0c             	mov    0xc(%ebp),%eax
 18d:	88 45 fc             	mov    %al,-0x4(%ebp)
 190:	eb 14                	jmp    1a6 <strchr+0x22>
 192:	8b 45 08             	mov    0x8(%ebp),%eax
 195:	0f b6 00             	movzbl (%eax),%eax
 198:	3a 45 fc             	cmp    -0x4(%ebp),%al
 19b:	75 05                	jne    1a2 <strchr+0x1e>
 19d:	8b 45 08             	mov    0x8(%ebp),%eax
 1a0:	eb 13                	jmp    1b5 <strchr+0x31>
 1a2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1a6:	8b 45 08             	mov    0x8(%ebp),%eax
 1a9:	0f b6 00             	movzbl (%eax),%eax
 1ac:	84 c0                	test   %al,%al
 1ae:	75 e2                	jne    192 <strchr+0xe>
 1b0:	b8 00 00 00 00       	mov    $0x0,%eax
 1b5:	c9                   	leave  
 1b6:	c3                   	ret    

000001b7 <gets>:
 1b7:	55                   	push   %ebp
 1b8:	89 e5                	mov    %esp,%ebp
 1ba:	83 ec 28             	sub    $0x28,%esp
 1bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1c4:	eb 4c                	jmp    212 <gets+0x5b>
 1c6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1cd:	00 
 1ce:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1d1:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1dc:	e8 44 01 00 00       	call   325 <read>
 1e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 1e4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1e8:	7f 02                	jg     1ec <gets+0x35>
 1ea:	eb 31                	jmp    21d <gets+0x66>
 1ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ef:	8d 50 01             	lea    0x1(%eax),%edx
 1f2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1f5:	89 c2                	mov    %eax,%edx
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	01 c2                	add    %eax,%edx
 1fc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 200:	88 02                	mov    %al,(%edx)
 202:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 206:	3c 0a                	cmp    $0xa,%al
 208:	74 13                	je     21d <gets+0x66>
 20a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 20e:	3c 0d                	cmp    $0xd,%al
 210:	74 0b                	je     21d <gets+0x66>
 212:	8b 45 f4             	mov    -0xc(%ebp),%eax
 215:	83 c0 01             	add    $0x1,%eax
 218:	3b 45 0c             	cmp    0xc(%ebp),%eax
 21b:	7c a9                	jl     1c6 <gets+0xf>
 21d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 220:	8b 45 08             	mov    0x8(%ebp),%eax
 223:	01 d0                	add    %edx,%eax
 225:	c6 00 00             	movb   $0x0,(%eax)
 228:	8b 45 08             	mov    0x8(%ebp),%eax
 22b:	c9                   	leave  
 22c:	c3                   	ret    

0000022d <stat>:
 22d:	55                   	push   %ebp
 22e:	89 e5                	mov    %esp,%ebp
 230:	83 ec 28             	sub    $0x28,%esp
 233:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 23a:	00 
 23b:	8b 45 08             	mov    0x8(%ebp),%eax
 23e:	89 04 24             	mov    %eax,(%esp)
 241:	e8 07 01 00 00       	call   34d <open>
 246:	89 45 f4             	mov    %eax,-0xc(%ebp)
 249:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 24d:	79 07                	jns    256 <stat+0x29>
 24f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 254:	eb 23                	jmp    279 <stat+0x4c>
 256:	8b 45 0c             	mov    0xc(%ebp),%eax
 259:	89 44 24 04          	mov    %eax,0x4(%esp)
 25d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 260:	89 04 24             	mov    %eax,(%esp)
 263:	e8 fd 00 00 00       	call   365 <fstat>
 268:	89 45 f0             	mov    %eax,-0x10(%ebp)
 26b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 26e:	89 04 24             	mov    %eax,(%esp)
 271:	e8 bf 00 00 00       	call   335 <close>
 276:	8b 45 f0             	mov    -0x10(%ebp),%eax
 279:	c9                   	leave  
 27a:	c3                   	ret    

0000027b <atoi>:
 27b:	55                   	push   %ebp
 27c:	89 e5                	mov    %esp,%ebp
 27e:	83 ec 10             	sub    $0x10,%esp
 281:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 288:	eb 25                	jmp    2af <atoi+0x34>
 28a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 28d:	89 d0                	mov    %edx,%eax
 28f:	c1 e0 02             	shl    $0x2,%eax
 292:	01 d0                	add    %edx,%eax
 294:	01 c0                	add    %eax,%eax
 296:	89 c1                	mov    %eax,%ecx
 298:	8b 45 08             	mov    0x8(%ebp),%eax
 29b:	8d 50 01             	lea    0x1(%eax),%edx
 29e:	89 55 08             	mov    %edx,0x8(%ebp)
 2a1:	0f b6 00             	movzbl (%eax),%eax
 2a4:	0f be c0             	movsbl %al,%eax
 2a7:	01 c8                	add    %ecx,%eax
 2a9:	83 e8 30             	sub    $0x30,%eax
 2ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2af:	8b 45 08             	mov    0x8(%ebp),%eax
 2b2:	0f b6 00             	movzbl (%eax),%eax
 2b5:	3c 2f                	cmp    $0x2f,%al
 2b7:	7e 0a                	jle    2c3 <atoi+0x48>
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	0f b6 00             	movzbl (%eax),%eax
 2bf:	3c 39                	cmp    $0x39,%al
 2c1:	7e c7                	jle    28a <atoi+0xf>
 2c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2c6:	c9                   	leave  
 2c7:	c3                   	ret    

000002c8 <memmove>:
 2c8:	55                   	push   %ebp
 2c9:	89 e5                	mov    %esp,%ebp
 2cb:	83 ec 10             	sub    $0x10,%esp
 2ce:	8b 45 08             	mov    0x8(%ebp),%eax
 2d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2d4:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d7:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2da:	eb 17                	jmp    2f3 <memmove+0x2b>
 2dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2df:	8d 50 01             	lea    0x1(%eax),%edx
 2e2:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2e5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2e8:	8d 4a 01             	lea    0x1(%edx),%ecx
 2eb:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2ee:	0f b6 12             	movzbl (%edx),%edx
 2f1:	88 10                	mov    %dl,(%eax)
 2f3:	8b 45 10             	mov    0x10(%ebp),%eax
 2f6:	8d 50 ff             	lea    -0x1(%eax),%edx
 2f9:	89 55 10             	mov    %edx,0x10(%ebp)
 2fc:	85 c0                	test   %eax,%eax
 2fe:	7f dc                	jg     2dc <memmove+0x14>
 300:	8b 45 08             	mov    0x8(%ebp),%eax
 303:	c9                   	leave  
 304:	c3                   	ret    

00000305 <fork>:
 305:	b8 01 00 00 00       	mov    $0x1,%eax
 30a:	cd 40                	int    $0x40
 30c:	c3                   	ret    

0000030d <exit>:
 30d:	b8 02 00 00 00       	mov    $0x2,%eax
 312:	cd 40                	int    $0x40
 314:	c3                   	ret    

00000315 <wait>:
 315:	b8 03 00 00 00       	mov    $0x3,%eax
 31a:	cd 40                	int    $0x40
 31c:	c3                   	ret    

0000031d <pipe>:
 31d:	b8 04 00 00 00       	mov    $0x4,%eax
 322:	cd 40                	int    $0x40
 324:	c3                   	ret    

00000325 <read>:
 325:	b8 05 00 00 00       	mov    $0x5,%eax
 32a:	cd 40                	int    $0x40
 32c:	c3                   	ret    

0000032d <write>:
 32d:	b8 10 00 00 00       	mov    $0x10,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret    

00000335 <close>:
 335:	b8 15 00 00 00       	mov    $0x15,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret    

0000033d <kill>:
 33d:	b8 06 00 00 00       	mov    $0x6,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret    

00000345 <exec>:
 345:	b8 07 00 00 00       	mov    $0x7,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret    

0000034d <open>:
 34d:	b8 0f 00 00 00       	mov    $0xf,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret    

00000355 <mknod>:
 355:	b8 11 00 00 00       	mov    $0x11,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret    

0000035d <unlink>:
 35d:	b8 12 00 00 00       	mov    $0x12,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret    

00000365 <fstat>:
 365:	b8 08 00 00 00       	mov    $0x8,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret    

0000036d <link>:
 36d:	b8 13 00 00 00       	mov    $0x13,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret    

00000375 <mkdir>:
 375:	b8 14 00 00 00       	mov    $0x14,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret    

0000037d <chdir>:
 37d:	b8 09 00 00 00       	mov    $0x9,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret    

00000385 <dup>:
 385:	b8 0a 00 00 00       	mov    $0xa,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret    

0000038d <getpid>:
 38d:	b8 0b 00 00 00       	mov    $0xb,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret    

00000395 <sbrk>:
 395:	b8 0c 00 00 00       	mov    $0xc,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret    

0000039d <sleep>:
 39d:	b8 0d 00 00 00       	mov    $0xd,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret    

000003a5 <uptime>:
 3a5:	b8 0e 00 00 00       	mov    $0xe,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret    

000003ad <my_syscall>:
 3ad:	b8 16 00 00 00       	mov    $0x16,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret    

000003b5 <yield>:
 3b5:	b8 17 00 00 00       	mov    $0x17,%eax
 3ba:	cd 40                	int    $0x40
 3bc:	c3                   	ret    

000003bd <getlev>:
 3bd:	b8 18 00 00 00       	mov    $0x18,%eax
 3c2:	cd 40                	int    $0x40
 3c4:	c3                   	ret    

000003c5 <set_cpu_share>:
 3c5:	b8 19 00 00 00       	mov    $0x19,%eax
 3ca:	cd 40                	int    $0x40
 3cc:	c3                   	ret    

000003cd <putc>:
 3cd:	55                   	push   %ebp
 3ce:	89 e5                	mov    %esp,%ebp
 3d0:	83 ec 18             	sub    $0x18,%esp
 3d3:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d6:	88 45 f4             	mov    %al,-0xc(%ebp)
 3d9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3e0:	00 
 3e1:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3e4:	89 44 24 04          	mov    %eax,0x4(%esp)
 3e8:	8b 45 08             	mov    0x8(%ebp),%eax
 3eb:	89 04 24             	mov    %eax,(%esp)
 3ee:	e8 3a ff ff ff       	call   32d <write>
 3f3:	c9                   	leave  
 3f4:	c3                   	ret    

000003f5 <printint>:
 3f5:	55                   	push   %ebp
 3f6:	89 e5                	mov    %esp,%ebp
 3f8:	56                   	push   %esi
 3f9:	53                   	push   %ebx
 3fa:	83 ec 30             	sub    $0x30,%esp
 3fd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 404:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 408:	74 17                	je     421 <printint+0x2c>
 40a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 40e:	79 11                	jns    421 <printint+0x2c>
 410:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 417:	8b 45 0c             	mov    0xc(%ebp),%eax
 41a:	f7 d8                	neg    %eax
 41c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41f:	eb 06                	jmp    427 <printint+0x32>
 421:	8b 45 0c             	mov    0xc(%ebp),%eax
 424:	89 45 ec             	mov    %eax,-0x14(%ebp)
 427:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 42e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 431:	8d 41 01             	lea    0x1(%ecx),%eax
 434:	89 45 f4             	mov    %eax,-0xc(%ebp)
 437:	8b 5d 10             	mov    0x10(%ebp),%ebx
 43a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 43d:	ba 00 00 00 00       	mov    $0x0,%edx
 442:	f7 f3                	div    %ebx
 444:	89 d0                	mov    %edx,%eax
 446:	0f b6 80 ec 0a 00 00 	movzbl 0xaec(%eax),%eax
 44d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 451:	8b 75 10             	mov    0x10(%ebp),%esi
 454:	8b 45 ec             	mov    -0x14(%ebp),%eax
 457:	ba 00 00 00 00       	mov    $0x0,%edx
 45c:	f7 f6                	div    %esi
 45e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 461:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 465:	75 c7                	jne    42e <printint+0x39>
 467:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 46b:	74 10                	je     47d <printint+0x88>
 46d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 470:	8d 50 01             	lea    0x1(%eax),%edx
 473:	89 55 f4             	mov    %edx,-0xc(%ebp)
 476:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 47b:	eb 1f                	jmp    49c <printint+0xa7>
 47d:	eb 1d                	jmp    49c <printint+0xa7>
 47f:	8d 55 dc             	lea    -0x24(%ebp),%edx
 482:	8b 45 f4             	mov    -0xc(%ebp),%eax
 485:	01 d0                	add    %edx,%eax
 487:	0f b6 00             	movzbl (%eax),%eax
 48a:	0f be c0             	movsbl %al,%eax
 48d:	89 44 24 04          	mov    %eax,0x4(%esp)
 491:	8b 45 08             	mov    0x8(%ebp),%eax
 494:	89 04 24             	mov    %eax,(%esp)
 497:	e8 31 ff ff ff       	call   3cd <putc>
 49c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4a4:	79 d9                	jns    47f <printint+0x8a>
 4a6:	83 c4 30             	add    $0x30,%esp
 4a9:	5b                   	pop    %ebx
 4aa:	5e                   	pop    %esi
 4ab:	5d                   	pop    %ebp
 4ac:	c3                   	ret    

000004ad <printf>:
 4ad:	55                   	push   %ebp
 4ae:	89 e5                	mov    %esp,%ebp
 4b0:	83 ec 38             	sub    $0x38,%esp
 4b3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 4ba:	8d 45 0c             	lea    0xc(%ebp),%eax
 4bd:	83 c0 04             	add    $0x4,%eax
 4c0:	89 45 e8             	mov    %eax,-0x18(%ebp)
 4c3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4ca:	e9 7c 01 00 00       	jmp    64b <printf+0x19e>
 4cf:	8b 55 0c             	mov    0xc(%ebp),%edx
 4d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4d5:	01 d0                	add    %edx,%eax
 4d7:	0f b6 00             	movzbl (%eax),%eax
 4da:	0f be c0             	movsbl %al,%eax
 4dd:	25 ff 00 00 00       	and    $0xff,%eax
 4e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 4e5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e9:	75 2c                	jne    517 <printf+0x6a>
 4eb:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ef:	75 0c                	jne    4fd <printf+0x50>
 4f1:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4f8:	e9 4a 01 00 00       	jmp    647 <printf+0x19a>
 4fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 500:	0f be c0             	movsbl %al,%eax
 503:	89 44 24 04          	mov    %eax,0x4(%esp)
 507:	8b 45 08             	mov    0x8(%ebp),%eax
 50a:	89 04 24             	mov    %eax,(%esp)
 50d:	e8 bb fe ff ff       	call   3cd <putc>
 512:	e9 30 01 00 00       	jmp    647 <printf+0x19a>
 517:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 51b:	0f 85 26 01 00 00    	jne    647 <printf+0x19a>
 521:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 525:	75 2d                	jne    554 <printf+0xa7>
 527:	8b 45 e8             	mov    -0x18(%ebp),%eax
 52a:	8b 00                	mov    (%eax),%eax
 52c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 533:	00 
 534:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 53b:	00 
 53c:	89 44 24 04          	mov    %eax,0x4(%esp)
 540:	8b 45 08             	mov    0x8(%ebp),%eax
 543:	89 04 24             	mov    %eax,(%esp)
 546:	e8 aa fe ff ff       	call   3f5 <printint>
 54b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 54f:	e9 ec 00 00 00       	jmp    640 <printf+0x193>
 554:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 558:	74 06                	je     560 <printf+0xb3>
 55a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 55e:	75 2d                	jne    58d <printf+0xe0>
 560:	8b 45 e8             	mov    -0x18(%ebp),%eax
 563:	8b 00                	mov    (%eax),%eax
 565:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 56c:	00 
 56d:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 574:	00 
 575:	89 44 24 04          	mov    %eax,0x4(%esp)
 579:	8b 45 08             	mov    0x8(%ebp),%eax
 57c:	89 04 24             	mov    %eax,(%esp)
 57f:	e8 71 fe ff ff       	call   3f5 <printint>
 584:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 588:	e9 b3 00 00 00       	jmp    640 <printf+0x193>
 58d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 591:	75 45                	jne    5d8 <printf+0x12b>
 593:	8b 45 e8             	mov    -0x18(%ebp),%eax
 596:	8b 00                	mov    (%eax),%eax
 598:	89 45 f4             	mov    %eax,-0xc(%ebp)
 59b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 59f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5a3:	75 09                	jne    5ae <printf+0x101>
 5a5:	c7 45 f4 98 08 00 00 	movl   $0x898,-0xc(%ebp)
 5ac:	eb 1e                	jmp    5cc <printf+0x11f>
 5ae:	eb 1c                	jmp    5cc <printf+0x11f>
 5b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b3:	0f b6 00             	movzbl (%eax),%eax
 5b6:	0f be c0             	movsbl %al,%eax
 5b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5bd:	8b 45 08             	mov    0x8(%ebp),%eax
 5c0:	89 04 24             	mov    %eax,(%esp)
 5c3:	e8 05 fe ff ff       	call   3cd <putc>
 5c8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5cf:	0f b6 00             	movzbl (%eax),%eax
 5d2:	84 c0                	test   %al,%al
 5d4:	75 da                	jne    5b0 <printf+0x103>
 5d6:	eb 68                	jmp    640 <printf+0x193>
 5d8:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5dc:	75 1d                	jne    5fb <printf+0x14e>
 5de:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e1:	8b 00                	mov    (%eax),%eax
 5e3:	0f be c0             	movsbl %al,%eax
 5e6:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ea:	8b 45 08             	mov    0x8(%ebp),%eax
 5ed:	89 04 24             	mov    %eax,(%esp)
 5f0:	e8 d8 fd ff ff       	call   3cd <putc>
 5f5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f9:	eb 45                	jmp    640 <printf+0x193>
 5fb:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ff:	75 17                	jne    618 <printf+0x16b>
 601:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 604:	0f be c0             	movsbl %al,%eax
 607:	89 44 24 04          	mov    %eax,0x4(%esp)
 60b:	8b 45 08             	mov    0x8(%ebp),%eax
 60e:	89 04 24             	mov    %eax,(%esp)
 611:	e8 b7 fd ff ff       	call   3cd <putc>
 616:	eb 28                	jmp    640 <printf+0x193>
 618:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 61f:	00 
 620:	8b 45 08             	mov    0x8(%ebp),%eax
 623:	89 04 24             	mov    %eax,(%esp)
 626:	e8 a2 fd ff ff       	call   3cd <putc>
 62b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 62e:	0f be c0             	movsbl %al,%eax
 631:	89 44 24 04          	mov    %eax,0x4(%esp)
 635:	8b 45 08             	mov    0x8(%ebp),%eax
 638:	89 04 24             	mov    %eax,(%esp)
 63b:	e8 8d fd ff ff       	call   3cd <putc>
 640:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 647:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 64b:	8b 55 0c             	mov    0xc(%ebp),%edx
 64e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 651:	01 d0                	add    %edx,%eax
 653:	0f b6 00             	movzbl (%eax),%eax
 656:	84 c0                	test   %al,%al
 658:	0f 85 71 fe ff ff    	jne    4cf <printf+0x22>
 65e:	c9                   	leave  
 65f:	c3                   	ret    

00000660 <free>:
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	83 ec 10             	sub    $0x10,%esp
 666:	8b 45 08             	mov    0x8(%ebp),%eax
 669:	83 e8 08             	sub    $0x8,%eax
 66c:	89 45 f8             	mov    %eax,-0x8(%ebp)
 66f:	a1 08 0b 00 00       	mov    0xb08,%eax
 674:	89 45 fc             	mov    %eax,-0x4(%ebp)
 677:	eb 24                	jmp    69d <free+0x3d>
 679:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67c:	8b 00                	mov    (%eax),%eax
 67e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 681:	77 12                	ja     695 <free+0x35>
 683:	8b 45 f8             	mov    -0x8(%ebp),%eax
 686:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 689:	77 24                	ja     6af <free+0x4f>
 68b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68e:	8b 00                	mov    (%eax),%eax
 690:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 693:	77 1a                	ja     6af <free+0x4f>
 695:	8b 45 fc             	mov    -0x4(%ebp),%eax
 698:	8b 00                	mov    (%eax),%eax
 69a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 69d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a3:	76 d4                	jbe    679 <free+0x19>
 6a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a8:	8b 00                	mov    (%eax),%eax
 6aa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6ad:	76 ca                	jbe    679 <free+0x19>
 6af:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b2:	8b 40 04             	mov    0x4(%eax),%eax
 6b5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bf:	01 c2                	add    %eax,%edx
 6c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c4:	8b 00                	mov    (%eax),%eax
 6c6:	39 c2                	cmp    %eax,%edx
 6c8:	75 24                	jne    6ee <free+0x8e>
 6ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cd:	8b 50 04             	mov    0x4(%eax),%edx
 6d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d3:	8b 00                	mov    (%eax),%eax
 6d5:	8b 40 04             	mov    0x4(%eax),%eax
 6d8:	01 c2                	add    %eax,%edx
 6da:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6dd:	89 50 04             	mov    %edx,0x4(%eax)
 6e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e3:	8b 00                	mov    (%eax),%eax
 6e5:	8b 10                	mov    (%eax),%edx
 6e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ea:	89 10                	mov    %edx,(%eax)
 6ec:	eb 0a                	jmp    6f8 <free+0x98>
 6ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f1:	8b 10                	mov    (%eax),%edx
 6f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f6:	89 10                	mov    %edx,(%eax)
 6f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fb:	8b 40 04             	mov    0x4(%eax),%eax
 6fe:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 705:	8b 45 fc             	mov    -0x4(%ebp),%eax
 708:	01 d0                	add    %edx,%eax
 70a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 70d:	75 20                	jne    72f <free+0xcf>
 70f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 712:	8b 50 04             	mov    0x4(%eax),%edx
 715:	8b 45 f8             	mov    -0x8(%ebp),%eax
 718:	8b 40 04             	mov    0x4(%eax),%eax
 71b:	01 c2                	add    %eax,%edx
 71d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 720:	89 50 04             	mov    %edx,0x4(%eax)
 723:	8b 45 f8             	mov    -0x8(%ebp),%eax
 726:	8b 10                	mov    (%eax),%edx
 728:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72b:	89 10                	mov    %edx,(%eax)
 72d:	eb 08                	jmp    737 <free+0xd7>
 72f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 732:	8b 55 f8             	mov    -0x8(%ebp),%edx
 735:	89 10                	mov    %edx,(%eax)
 737:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73a:	a3 08 0b 00 00       	mov    %eax,0xb08
 73f:	c9                   	leave  
 740:	c3                   	ret    

00000741 <morecore>:
 741:	55                   	push   %ebp
 742:	89 e5                	mov    %esp,%ebp
 744:	83 ec 28             	sub    $0x28,%esp
 747:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 74e:	77 07                	ja     757 <morecore+0x16>
 750:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 757:	8b 45 08             	mov    0x8(%ebp),%eax
 75a:	c1 e0 03             	shl    $0x3,%eax
 75d:	89 04 24             	mov    %eax,(%esp)
 760:	e8 30 fc ff ff       	call   395 <sbrk>
 765:	89 45 f4             	mov    %eax,-0xc(%ebp)
 768:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 76c:	75 07                	jne    775 <morecore+0x34>
 76e:	b8 00 00 00 00       	mov    $0x0,%eax
 773:	eb 22                	jmp    797 <morecore+0x56>
 775:	8b 45 f4             	mov    -0xc(%ebp),%eax
 778:	89 45 f0             	mov    %eax,-0x10(%ebp)
 77b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77e:	8b 55 08             	mov    0x8(%ebp),%edx
 781:	89 50 04             	mov    %edx,0x4(%eax)
 784:	8b 45 f0             	mov    -0x10(%ebp),%eax
 787:	83 c0 08             	add    $0x8,%eax
 78a:	89 04 24             	mov    %eax,(%esp)
 78d:	e8 ce fe ff ff       	call   660 <free>
 792:	a1 08 0b 00 00       	mov    0xb08,%eax
 797:	c9                   	leave  
 798:	c3                   	ret    

00000799 <malloc>:
 799:	55                   	push   %ebp
 79a:	89 e5                	mov    %esp,%ebp
 79c:	83 ec 28             	sub    $0x28,%esp
 79f:	8b 45 08             	mov    0x8(%ebp),%eax
 7a2:	83 c0 07             	add    $0x7,%eax
 7a5:	c1 e8 03             	shr    $0x3,%eax
 7a8:	83 c0 01             	add    $0x1,%eax
 7ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
 7ae:	a1 08 0b 00 00       	mov    0xb08,%eax
 7b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7ba:	75 23                	jne    7df <malloc+0x46>
 7bc:	c7 45 f0 00 0b 00 00 	movl   $0xb00,-0x10(%ebp)
 7c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c6:	a3 08 0b 00 00       	mov    %eax,0xb08
 7cb:	a1 08 0b 00 00       	mov    0xb08,%eax
 7d0:	a3 00 0b 00 00       	mov    %eax,0xb00
 7d5:	c7 05 04 0b 00 00 00 	movl   $0x0,0xb04
 7dc:	00 00 00 
 7df:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e2:	8b 00                	mov    (%eax),%eax
 7e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ea:	8b 40 04             	mov    0x4(%eax),%eax
 7ed:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7f0:	72 4d                	jb     83f <malloc+0xa6>
 7f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f5:	8b 40 04             	mov    0x4(%eax),%eax
 7f8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7fb:	75 0c                	jne    809 <malloc+0x70>
 7fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 800:	8b 10                	mov    (%eax),%edx
 802:	8b 45 f0             	mov    -0x10(%ebp),%eax
 805:	89 10                	mov    %edx,(%eax)
 807:	eb 26                	jmp    82f <malloc+0x96>
 809:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80c:	8b 40 04             	mov    0x4(%eax),%eax
 80f:	2b 45 ec             	sub    -0x14(%ebp),%eax
 812:	89 c2                	mov    %eax,%edx
 814:	8b 45 f4             	mov    -0xc(%ebp),%eax
 817:	89 50 04             	mov    %edx,0x4(%eax)
 81a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81d:	8b 40 04             	mov    0x4(%eax),%eax
 820:	c1 e0 03             	shl    $0x3,%eax
 823:	01 45 f4             	add    %eax,-0xc(%ebp)
 826:	8b 45 f4             	mov    -0xc(%ebp),%eax
 829:	8b 55 ec             	mov    -0x14(%ebp),%edx
 82c:	89 50 04             	mov    %edx,0x4(%eax)
 82f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 832:	a3 08 0b 00 00       	mov    %eax,0xb08
 837:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83a:	83 c0 08             	add    $0x8,%eax
 83d:	eb 38                	jmp    877 <malloc+0xde>
 83f:	a1 08 0b 00 00       	mov    0xb08,%eax
 844:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 847:	75 1b                	jne    864 <malloc+0xcb>
 849:	8b 45 ec             	mov    -0x14(%ebp),%eax
 84c:	89 04 24             	mov    %eax,(%esp)
 84f:	e8 ed fe ff ff       	call   741 <morecore>
 854:	89 45 f4             	mov    %eax,-0xc(%ebp)
 857:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 85b:	75 07                	jne    864 <malloc+0xcb>
 85d:	b8 00 00 00 00       	mov    $0x0,%eax
 862:	eb 13                	jmp    877 <malloc+0xde>
 864:	8b 45 f4             	mov    -0xc(%ebp),%eax
 867:	89 45 f0             	mov    %eax,-0x10(%ebp)
 86a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86d:	8b 00                	mov    (%eax),%eax
 86f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 872:	e9 70 ff ff ff       	jmp    7e7 <malloc+0x4e>
 877:	c9                   	leave  
 878:	c3                   	ret    
