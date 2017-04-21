
_test_master:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  {NAME_CHILD_MLFQ, "1", 0},
};

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
  int pid;
  int i;

  for (i = 0; i < CNT_CHILD; i++) {
  11:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  18:	eb 7a                	jmp    94 <main+0x94>
    pid = fork();
  1a:	e8 f8 02 00 00       	call   317 <fork>
  1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (pid > 0) {
  22:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  26:	7e 06                	jle    2e <main+0x2e>
main(int argc, char *argv[])
{
  int pid;
  int i;

  for (i = 0; i < CNT_CHILD; i++) {
  28:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  2c:	eb 66                	jmp    94 <main+0x94>
    pid = fork();
    if (pid > 0) {
      // parent
      continue;
    } else if (pid == 0) {
  2e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  32:	75 49                	jne    7d <main+0x7d>
      // child
      exec(child_argv[i][0], child_argv[i]);
  34:	8b 55 f4             	mov    -0xc(%ebp),%edx
  37:	89 d0                	mov    %edx,%eax
  39:	01 c0                	add    %eax,%eax
  3b:	01 d0                	add    %edx,%eax
  3d:	c1 e0 02             	shl    $0x2,%eax
  40:	8d 88 0c 0b 00 00    	lea    0xb0c(%eax),%ecx
  46:	8b 55 f4             	mov    -0xc(%ebp),%edx
  49:	89 d0                	mov    %edx,%eax
  4b:	01 c0                	add    %eax,%eax
  4d:	01 d0                	add    %edx,%eax
  4f:	c1 e0 02             	shl    $0x2,%eax
  52:	05 0c 0b 00 00       	add    $0xb0c,%eax
  57:	8b 00                	mov    (%eax),%eax
  59:	83 ec 08             	sub    $0x8,%esp
  5c:	51                   	push   %ecx
  5d:	50                   	push   %eax
  5e:	e8 f4 02 00 00       	call   357 <exec>
  63:	83 c4 10             	add    $0x10,%esp
      printf(1, "exec failed!!\n");
  66:	83 ec 08             	sub    $0x8,%esp
  69:	68 99 08 00 00       	push   $0x899
  6e:	6a 01                	push   $0x1
  70:	e8 4a 04 00 00       	call   4bf <printf>
  75:	83 c4 10             	add    $0x10,%esp
      exit();
  78:	e8 a2 02 00 00       	call   31f <exit>
    } else {
      printf(1, "fork failed!!\n");
  7d:	83 ec 08             	sub    $0x8,%esp
  80:	68 a8 08 00 00       	push   $0x8a8
  85:	6a 01                	push   $0x1
  87:	e8 33 04 00 00       	call   4bf <printf>
  8c:	83 c4 10             	add    $0x10,%esp
      exit();
  8f:	e8 8b 02 00 00       	call   31f <exit>
main(int argc, char *argv[])
{
  int pid;
  int i;

  for (i = 0; i < CNT_CHILD; i++) {
  94:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  98:	7e 80                	jle    1a <main+0x1a>
      printf(1, "fork failed!!\n");
      exit();
    }
  }
  
  for (i = 0; i < CNT_CHILD; i++) {
  9a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  a1:	eb 09                	jmp    ac <main+0xac>
    wait();
  a3:	e8 7f 02 00 00       	call   327 <wait>
      printf(1, "fork failed!!\n");
      exit();
    }
  }
  
  for (i = 0; i < CNT_CHILD; i++) {
  a8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  ac:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  b0:	7e f1                	jle    a3 <main+0xa3>
    wait();
  }

  exit();
  b2:	e8 68 02 00 00       	call   31f <exit>

000000b7 <stosb>:
  b7:	55                   	push   %ebp
  b8:	89 e5                	mov    %esp,%ebp
  ba:	57                   	push   %edi
  bb:	53                   	push   %ebx
  bc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  bf:	8b 55 10             	mov    0x10(%ebp),%edx
  c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  c5:	89 cb                	mov    %ecx,%ebx
  c7:	89 df                	mov    %ebx,%edi
  c9:	89 d1                	mov    %edx,%ecx
  cb:	fc                   	cld    
  cc:	f3 aa                	rep stos %al,%es:(%edi)
  ce:	89 ca                	mov    %ecx,%edx
  d0:	89 fb                	mov    %edi,%ebx
  d2:	89 5d 08             	mov    %ebx,0x8(%ebp)
  d5:	89 55 10             	mov    %edx,0x10(%ebp)
  d8:	5b                   	pop    %ebx
  d9:	5f                   	pop    %edi
  da:	5d                   	pop    %ebp
  db:	c3                   	ret    

000000dc <strcpy>:
  dc:	55                   	push   %ebp
  dd:	89 e5                	mov    %esp,%ebp
  df:	83 ec 10             	sub    $0x10,%esp
  e2:	8b 45 08             	mov    0x8(%ebp),%eax
  e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  e8:	90                   	nop
  e9:	8b 45 08             	mov    0x8(%ebp),%eax
  ec:	8d 50 01             	lea    0x1(%eax),%edx
  ef:	89 55 08             	mov    %edx,0x8(%ebp)
  f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  f5:	8d 4a 01             	lea    0x1(%edx),%ecx
  f8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  fb:	0f b6 12             	movzbl (%edx),%edx
  fe:	88 10                	mov    %dl,(%eax)
 100:	0f b6 00             	movzbl (%eax),%eax
 103:	84 c0                	test   %al,%al
 105:	75 e2                	jne    e9 <strcpy+0xd>
 107:	8b 45 fc             	mov    -0x4(%ebp),%eax
 10a:	c9                   	leave  
 10b:	c3                   	ret    

0000010c <strcmp>:
 10c:	55                   	push   %ebp
 10d:	89 e5                	mov    %esp,%ebp
 10f:	eb 08                	jmp    119 <strcmp+0xd>
 111:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 115:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 119:	8b 45 08             	mov    0x8(%ebp),%eax
 11c:	0f b6 00             	movzbl (%eax),%eax
 11f:	84 c0                	test   %al,%al
 121:	74 10                	je     133 <strcmp+0x27>
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	0f b6 10             	movzbl (%eax),%edx
 129:	8b 45 0c             	mov    0xc(%ebp),%eax
 12c:	0f b6 00             	movzbl (%eax),%eax
 12f:	38 c2                	cmp    %al,%dl
 131:	74 de                	je     111 <strcmp+0x5>
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	0f b6 00             	movzbl (%eax),%eax
 139:	0f b6 d0             	movzbl %al,%edx
 13c:	8b 45 0c             	mov    0xc(%ebp),%eax
 13f:	0f b6 00             	movzbl (%eax),%eax
 142:	0f b6 c0             	movzbl %al,%eax
 145:	29 c2                	sub    %eax,%edx
 147:	89 d0                	mov    %edx,%eax
 149:	5d                   	pop    %ebp
 14a:	c3                   	ret    

0000014b <strlen>:
 14b:	55                   	push   %ebp
 14c:	89 e5                	mov    %esp,%ebp
 14e:	83 ec 10             	sub    $0x10,%esp
 151:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 158:	eb 04                	jmp    15e <strlen+0x13>
 15a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 15e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 161:	8b 45 08             	mov    0x8(%ebp),%eax
 164:	01 d0                	add    %edx,%eax
 166:	0f b6 00             	movzbl (%eax),%eax
 169:	84 c0                	test   %al,%al
 16b:	75 ed                	jne    15a <strlen+0xf>
 16d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 170:	c9                   	leave  
 171:	c3                   	ret    

00000172 <memset>:
 172:	55                   	push   %ebp
 173:	89 e5                	mov    %esp,%ebp
 175:	83 ec 0c             	sub    $0xc,%esp
 178:	8b 45 10             	mov    0x10(%ebp),%eax
 17b:	89 44 24 08          	mov    %eax,0x8(%esp)
 17f:	8b 45 0c             	mov    0xc(%ebp),%eax
 182:	89 44 24 04          	mov    %eax,0x4(%esp)
 186:	8b 45 08             	mov    0x8(%ebp),%eax
 189:	89 04 24             	mov    %eax,(%esp)
 18c:	e8 26 ff ff ff       	call   b7 <stosb>
 191:	8b 45 08             	mov    0x8(%ebp),%eax
 194:	c9                   	leave  
 195:	c3                   	ret    

00000196 <strchr>:
 196:	55                   	push   %ebp
 197:	89 e5                	mov    %esp,%ebp
 199:	83 ec 04             	sub    $0x4,%esp
 19c:	8b 45 0c             	mov    0xc(%ebp),%eax
 19f:	88 45 fc             	mov    %al,-0x4(%ebp)
 1a2:	eb 14                	jmp    1b8 <strchr+0x22>
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	0f b6 00             	movzbl (%eax),%eax
 1aa:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1ad:	75 05                	jne    1b4 <strchr+0x1e>
 1af:	8b 45 08             	mov    0x8(%ebp),%eax
 1b2:	eb 13                	jmp    1c7 <strchr+0x31>
 1b4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1b8:	8b 45 08             	mov    0x8(%ebp),%eax
 1bb:	0f b6 00             	movzbl (%eax),%eax
 1be:	84 c0                	test   %al,%al
 1c0:	75 e2                	jne    1a4 <strchr+0xe>
 1c2:	b8 00 00 00 00       	mov    $0x0,%eax
 1c7:	c9                   	leave  
 1c8:	c3                   	ret    

000001c9 <gets>:
 1c9:	55                   	push   %ebp
 1ca:	89 e5                	mov    %esp,%ebp
 1cc:	83 ec 28             	sub    $0x28,%esp
 1cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1d6:	eb 4c                	jmp    224 <gets+0x5b>
 1d8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1df:	00 
 1e0:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1e3:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1ee:	e8 44 01 00 00       	call   337 <read>
 1f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 1f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1fa:	7f 02                	jg     1fe <gets+0x35>
 1fc:	eb 31                	jmp    22f <gets+0x66>
 1fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 201:	8d 50 01             	lea    0x1(%eax),%edx
 204:	89 55 f4             	mov    %edx,-0xc(%ebp)
 207:	89 c2                	mov    %eax,%edx
 209:	8b 45 08             	mov    0x8(%ebp),%eax
 20c:	01 c2                	add    %eax,%edx
 20e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 212:	88 02                	mov    %al,(%edx)
 214:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 218:	3c 0a                	cmp    $0xa,%al
 21a:	74 13                	je     22f <gets+0x66>
 21c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 220:	3c 0d                	cmp    $0xd,%al
 222:	74 0b                	je     22f <gets+0x66>
 224:	8b 45 f4             	mov    -0xc(%ebp),%eax
 227:	83 c0 01             	add    $0x1,%eax
 22a:	3b 45 0c             	cmp    0xc(%ebp),%eax
 22d:	7c a9                	jl     1d8 <gets+0xf>
 22f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 232:	8b 45 08             	mov    0x8(%ebp),%eax
 235:	01 d0                	add    %edx,%eax
 237:	c6 00 00             	movb   $0x0,(%eax)
 23a:	8b 45 08             	mov    0x8(%ebp),%eax
 23d:	c9                   	leave  
 23e:	c3                   	ret    

0000023f <stat>:
 23f:	55                   	push   %ebp
 240:	89 e5                	mov    %esp,%ebp
 242:	83 ec 28             	sub    $0x28,%esp
 245:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 24c:	00 
 24d:	8b 45 08             	mov    0x8(%ebp),%eax
 250:	89 04 24             	mov    %eax,(%esp)
 253:	e8 07 01 00 00       	call   35f <open>
 258:	89 45 f4             	mov    %eax,-0xc(%ebp)
 25b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 25f:	79 07                	jns    268 <stat+0x29>
 261:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 266:	eb 23                	jmp    28b <stat+0x4c>
 268:	8b 45 0c             	mov    0xc(%ebp),%eax
 26b:	89 44 24 04          	mov    %eax,0x4(%esp)
 26f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 272:	89 04 24             	mov    %eax,(%esp)
 275:	e8 fd 00 00 00       	call   377 <fstat>
 27a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 27d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 280:	89 04 24             	mov    %eax,(%esp)
 283:	e8 bf 00 00 00       	call   347 <close>
 288:	8b 45 f0             	mov    -0x10(%ebp),%eax
 28b:	c9                   	leave  
 28c:	c3                   	ret    

0000028d <atoi>:
 28d:	55                   	push   %ebp
 28e:	89 e5                	mov    %esp,%ebp
 290:	83 ec 10             	sub    $0x10,%esp
 293:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 29a:	eb 25                	jmp    2c1 <atoi+0x34>
 29c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 29f:	89 d0                	mov    %edx,%eax
 2a1:	c1 e0 02             	shl    $0x2,%eax
 2a4:	01 d0                	add    %edx,%eax
 2a6:	01 c0                	add    %eax,%eax
 2a8:	89 c1                	mov    %eax,%ecx
 2aa:	8b 45 08             	mov    0x8(%ebp),%eax
 2ad:	8d 50 01             	lea    0x1(%eax),%edx
 2b0:	89 55 08             	mov    %edx,0x8(%ebp)
 2b3:	0f b6 00             	movzbl (%eax),%eax
 2b6:	0f be c0             	movsbl %al,%eax
 2b9:	01 c8                	add    %ecx,%eax
 2bb:	83 e8 30             	sub    $0x30,%eax
 2be:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2c1:	8b 45 08             	mov    0x8(%ebp),%eax
 2c4:	0f b6 00             	movzbl (%eax),%eax
 2c7:	3c 2f                	cmp    $0x2f,%al
 2c9:	7e 0a                	jle    2d5 <atoi+0x48>
 2cb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ce:	0f b6 00             	movzbl (%eax),%eax
 2d1:	3c 39                	cmp    $0x39,%al
 2d3:	7e c7                	jle    29c <atoi+0xf>
 2d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2d8:	c9                   	leave  
 2d9:	c3                   	ret    

000002da <memmove>:
 2da:	55                   	push   %ebp
 2db:	89 e5                	mov    %esp,%ebp
 2dd:	83 ec 10             	sub    $0x10,%esp
 2e0:	8b 45 08             	mov    0x8(%ebp),%eax
 2e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2e6:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2ec:	eb 17                	jmp    305 <memmove+0x2b>
 2ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2f1:	8d 50 01             	lea    0x1(%eax),%edx
 2f4:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2f7:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2fa:	8d 4a 01             	lea    0x1(%edx),%ecx
 2fd:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 300:	0f b6 12             	movzbl (%edx),%edx
 303:	88 10                	mov    %dl,(%eax)
 305:	8b 45 10             	mov    0x10(%ebp),%eax
 308:	8d 50 ff             	lea    -0x1(%eax),%edx
 30b:	89 55 10             	mov    %edx,0x10(%ebp)
 30e:	85 c0                	test   %eax,%eax
 310:	7f dc                	jg     2ee <memmove+0x14>
 312:	8b 45 08             	mov    0x8(%ebp),%eax
 315:	c9                   	leave  
 316:	c3                   	ret    

00000317 <fork>:
 317:	b8 01 00 00 00       	mov    $0x1,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <exit>:
 31f:	b8 02 00 00 00       	mov    $0x2,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <wait>:
 327:	b8 03 00 00 00       	mov    $0x3,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <pipe>:
 32f:	b8 04 00 00 00       	mov    $0x4,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <read>:
 337:	b8 05 00 00 00       	mov    $0x5,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <write>:
 33f:	b8 10 00 00 00       	mov    $0x10,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <close>:
 347:	b8 15 00 00 00       	mov    $0x15,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <kill>:
 34f:	b8 06 00 00 00       	mov    $0x6,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <exec>:
 357:	b8 07 00 00 00       	mov    $0x7,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <open>:
 35f:	b8 0f 00 00 00       	mov    $0xf,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <mknod>:
 367:	b8 11 00 00 00       	mov    $0x11,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <unlink>:
 36f:	b8 12 00 00 00       	mov    $0x12,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <fstat>:
 377:	b8 08 00 00 00       	mov    $0x8,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <link>:
 37f:	b8 13 00 00 00       	mov    $0x13,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <mkdir>:
 387:	b8 14 00 00 00       	mov    $0x14,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <chdir>:
 38f:	b8 09 00 00 00       	mov    $0x9,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <dup>:
 397:	b8 0a 00 00 00       	mov    $0xa,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <getpid>:
 39f:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <sbrk>:
 3a7:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <sleep>:
 3af:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <uptime>:
 3b7:	b8 0e 00 00 00       	mov    $0xe,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <my_syscall>:
 3bf:	b8 16 00 00 00       	mov    $0x16,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <yield>:
 3c7:	b8 17 00 00 00       	mov    $0x17,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <getlev>:
 3cf:	b8 18 00 00 00       	mov    $0x18,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret    

000003d7 <set_cpu_share>:
 3d7:	b8 19 00 00 00       	mov    $0x19,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret    

000003df <putc>:
 3df:	55                   	push   %ebp
 3e0:	89 e5                	mov    %esp,%ebp
 3e2:	83 ec 18             	sub    $0x18,%esp
 3e5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e8:	88 45 f4             	mov    %al,-0xc(%ebp)
 3eb:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3f2:	00 
 3f3:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3f6:	89 44 24 04          	mov    %eax,0x4(%esp)
 3fa:	8b 45 08             	mov    0x8(%ebp),%eax
 3fd:	89 04 24             	mov    %eax,(%esp)
 400:	e8 3a ff ff ff       	call   33f <write>
 405:	c9                   	leave  
 406:	c3                   	ret    

00000407 <printint>:
 407:	55                   	push   %ebp
 408:	89 e5                	mov    %esp,%ebp
 40a:	56                   	push   %esi
 40b:	53                   	push   %ebx
 40c:	83 ec 30             	sub    $0x30,%esp
 40f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 416:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 41a:	74 17                	je     433 <printint+0x2c>
 41c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 420:	79 11                	jns    433 <printint+0x2c>
 422:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 429:	8b 45 0c             	mov    0xc(%ebp),%eax
 42c:	f7 d8                	neg    %eax
 42e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 431:	eb 06                	jmp    439 <printint+0x32>
 433:	8b 45 0c             	mov    0xc(%ebp),%eax
 436:	89 45 ec             	mov    %eax,-0x14(%ebp)
 439:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 440:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 443:	8d 41 01             	lea    0x1(%ecx),%eax
 446:	89 45 f4             	mov    %eax,-0xc(%ebp)
 449:	8b 5d 10             	mov    0x10(%ebp),%ebx
 44c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 44f:	ba 00 00 00 00       	mov    $0x0,%edx
 454:	f7 f3                	div    %ebx
 456:	89 d0                	mov    %edx,%eax
 458:	0f b6 80 24 0b 00 00 	movzbl 0xb24(%eax),%eax
 45f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 463:	8b 75 10             	mov    0x10(%ebp),%esi
 466:	8b 45 ec             	mov    -0x14(%ebp),%eax
 469:	ba 00 00 00 00       	mov    $0x0,%edx
 46e:	f7 f6                	div    %esi
 470:	89 45 ec             	mov    %eax,-0x14(%ebp)
 473:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 477:	75 c7                	jne    440 <printint+0x39>
 479:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 47d:	74 10                	je     48f <printint+0x88>
 47f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 482:	8d 50 01             	lea    0x1(%eax),%edx
 485:	89 55 f4             	mov    %edx,-0xc(%ebp)
 488:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 48d:	eb 1f                	jmp    4ae <printint+0xa7>
 48f:	eb 1d                	jmp    4ae <printint+0xa7>
 491:	8d 55 dc             	lea    -0x24(%ebp),%edx
 494:	8b 45 f4             	mov    -0xc(%ebp),%eax
 497:	01 d0                	add    %edx,%eax
 499:	0f b6 00             	movzbl (%eax),%eax
 49c:	0f be c0             	movsbl %al,%eax
 49f:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a3:	8b 45 08             	mov    0x8(%ebp),%eax
 4a6:	89 04 24             	mov    %eax,(%esp)
 4a9:	e8 31 ff ff ff       	call   3df <putc>
 4ae:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4b6:	79 d9                	jns    491 <printint+0x8a>
 4b8:	83 c4 30             	add    $0x30,%esp
 4bb:	5b                   	pop    %ebx
 4bc:	5e                   	pop    %esi
 4bd:	5d                   	pop    %ebp
 4be:	c3                   	ret    

000004bf <printf>:
 4bf:	55                   	push   %ebp
 4c0:	89 e5                	mov    %esp,%ebp
 4c2:	83 ec 38             	sub    $0x38,%esp
 4c5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 4cc:	8d 45 0c             	lea    0xc(%ebp),%eax
 4cf:	83 c0 04             	add    $0x4,%eax
 4d2:	89 45 e8             	mov    %eax,-0x18(%ebp)
 4d5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4dc:	e9 7c 01 00 00       	jmp    65d <printf+0x19e>
 4e1:	8b 55 0c             	mov    0xc(%ebp),%edx
 4e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4e7:	01 d0                	add    %edx,%eax
 4e9:	0f b6 00             	movzbl (%eax),%eax
 4ec:	0f be c0             	movsbl %al,%eax
 4ef:	25 ff 00 00 00       	and    $0xff,%eax
 4f4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 4f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4fb:	75 2c                	jne    529 <printf+0x6a>
 4fd:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 501:	75 0c                	jne    50f <printf+0x50>
 503:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 50a:	e9 4a 01 00 00       	jmp    659 <printf+0x19a>
 50f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 512:	0f be c0             	movsbl %al,%eax
 515:	89 44 24 04          	mov    %eax,0x4(%esp)
 519:	8b 45 08             	mov    0x8(%ebp),%eax
 51c:	89 04 24             	mov    %eax,(%esp)
 51f:	e8 bb fe ff ff       	call   3df <putc>
 524:	e9 30 01 00 00       	jmp    659 <printf+0x19a>
 529:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 52d:	0f 85 26 01 00 00    	jne    659 <printf+0x19a>
 533:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 537:	75 2d                	jne    566 <printf+0xa7>
 539:	8b 45 e8             	mov    -0x18(%ebp),%eax
 53c:	8b 00                	mov    (%eax),%eax
 53e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 545:	00 
 546:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 54d:	00 
 54e:	89 44 24 04          	mov    %eax,0x4(%esp)
 552:	8b 45 08             	mov    0x8(%ebp),%eax
 555:	89 04 24             	mov    %eax,(%esp)
 558:	e8 aa fe ff ff       	call   407 <printint>
 55d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 561:	e9 ec 00 00 00       	jmp    652 <printf+0x193>
 566:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 56a:	74 06                	je     572 <printf+0xb3>
 56c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 570:	75 2d                	jne    59f <printf+0xe0>
 572:	8b 45 e8             	mov    -0x18(%ebp),%eax
 575:	8b 00                	mov    (%eax),%eax
 577:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 57e:	00 
 57f:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 586:	00 
 587:	89 44 24 04          	mov    %eax,0x4(%esp)
 58b:	8b 45 08             	mov    0x8(%ebp),%eax
 58e:	89 04 24             	mov    %eax,(%esp)
 591:	e8 71 fe ff ff       	call   407 <printint>
 596:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 59a:	e9 b3 00 00 00       	jmp    652 <printf+0x193>
 59f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5a3:	75 45                	jne    5ea <printf+0x12b>
 5a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a8:	8b 00                	mov    (%eax),%eax
 5aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
 5ad:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5b5:	75 09                	jne    5c0 <printf+0x101>
 5b7:	c7 45 f4 b7 08 00 00 	movl   $0x8b7,-0xc(%ebp)
 5be:	eb 1e                	jmp    5de <printf+0x11f>
 5c0:	eb 1c                	jmp    5de <printf+0x11f>
 5c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c5:	0f b6 00             	movzbl (%eax),%eax
 5c8:	0f be c0             	movsbl %al,%eax
 5cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cf:	8b 45 08             	mov    0x8(%ebp),%eax
 5d2:	89 04 24             	mov    %eax,(%esp)
 5d5:	e8 05 fe ff ff       	call   3df <putc>
 5da:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e1:	0f b6 00             	movzbl (%eax),%eax
 5e4:	84 c0                	test   %al,%al
 5e6:	75 da                	jne    5c2 <printf+0x103>
 5e8:	eb 68                	jmp    652 <printf+0x193>
 5ea:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5ee:	75 1d                	jne    60d <printf+0x14e>
 5f0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5f3:	8b 00                	mov    (%eax),%eax
 5f5:	0f be c0             	movsbl %al,%eax
 5f8:	89 44 24 04          	mov    %eax,0x4(%esp)
 5fc:	8b 45 08             	mov    0x8(%ebp),%eax
 5ff:	89 04 24             	mov    %eax,(%esp)
 602:	e8 d8 fd ff ff       	call   3df <putc>
 607:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 60b:	eb 45                	jmp    652 <printf+0x193>
 60d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 611:	75 17                	jne    62a <printf+0x16b>
 613:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 616:	0f be c0             	movsbl %al,%eax
 619:	89 44 24 04          	mov    %eax,0x4(%esp)
 61d:	8b 45 08             	mov    0x8(%ebp),%eax
 620:	89 04 24             	mov    %eax,(%esp)
 623:	e8 b7 fd ff ff       	call   3df <putc>
 628:	eb 28                	jmp    652 <printf+0x193>
 62a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 631:	00 
 632:	8b 45 08             	mov    0x8(%ebp),%eax
 635:	89 04 24             	mov    %eax,(%esp)
 638:	e8 a2 fd ff ff       	call   3df <putc>
 63d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 640:	0f be c0             	movsbl %al,%eax
 643:	89 44 24 04          	mov    %eax,0x4(%esp)
 647:	8b 45 08             	mov    0x8(%ebp),%eax
 64a:	89 04 24             	mov    %eax,(%esp)
 64d:	e8 8d fd ff ff       	call   3df <putc>
 652:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 659:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 65d:	8b 55 0c             	mov    0xc(%ebp),%edx
 660:	8b 45 f0             	mov    -0x10(%ebp),%eax
 663:	01 d0                	add    %edx,%eax
 665:	0f b6 00             	movzbl (%eax),%eax
 668:	84 c0                	test   %al,%al
 66a:	0f 85 71 fe ff ff    	jne    4e1 <printf+0x22>
 670:	c9                   	leave  
 671:	c3                   	ret    

00000672 <free>:
 672:	55                   	push   %ebp
 673:	89 e5                	mov    %esp,%ebp
 675:	83 ec 10             	sub    $0x10,%esp
 678:	8b 45 08             	mov    0x8(%ebp),%eax
 67b:	83 e8 08             	sub    $0x8,%eax
 67e:	89 45 f8             	mov    %eax,-0x8(%ebp)
 681:	a1 40 0b 00 00       	mov    0xb40,%eax
 686:	89 45 fc             	mov    %eax,-0x4(%ebp)
 689:	eb 24                	jmp    6af <free+0x3d>
 68b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68e:	8b 00                	mov    (%eax),%eax
 690:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 693:	77 12                	ja     6a7 <free+0x35>
 695:	8b 45 f8             	mov    -0x8(%ebp),%eax
 698:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 69b:	77 24                	ja     6c1 <free+0x4f>
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	8b 00                	mov    (%eax),%eax
 6a2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a5:	77 1a                	ja     6c1 <free+0x4f>
 6a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6aa:	8b 00                	mov    (%eax),%eax
 6ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6af:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6b5:	76 d4                	jbe    68b <free+0x19>
 6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ba:	8b 00                	mov    (%eax),%eax
 6bc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6bf:	76 ca                	jbe    68b <free+0x19>
 6c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c4:	8b 40 04             	mov    0x4(%eax),%eax
 6c7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d1:	01 c2                	add    %eax,%edx
 6d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d6:	8b 00                	mov    (%eax),%eax
 6d8:	39 c2                	cmp    %eax,%edx
 6da:	75 24                	jne    700 <free+0x8e>
 6dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6df:	8b 50 04             	mov    0x4(%eax),%edx
 6e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e5:	8b 00                	mov    (%eax),%eax
 6e7:	8b 40 04             	mov    0x4(%eax),%eax
 6ea:	01 c2                	add    %eax,%edx
 6ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ef:	89 50 04             	mov    %edx,0x4(%eax)
 6f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f5:	8b 00                	mov    (%eax),%eax
 6f7:	8b 10                	mov    (%eax),%edx
 6f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fc:	89 10                	mov    %edx,(%eax)
 6fe:	eb 0a                	jmp    70a <free+0x98>
 700:	8b 45 fc             	mov    -0x4(%ebp),%eax
 703:	8b 10                	mov    (%eax),%edx
 705:	8b 45 f8             	mov    -0x8(%ebp),%eax
 708:	89 10                	mov    %edx,(%eax)
 70a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70d:	8b 40 04             	mov    0x4(%eax),%eax
 710:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 717:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71a:	01 d0                	add    %edx,%eax
 71c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 71f:	75 20                	jne    741 <free+0xcf>
 721:	8b 45 fc             	mov    -0x4(%ebp),%eax
 724:	8b 50 04             	mov    0x4(%eax),%edx
 727:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72a:	8b 40 04             	mov    0x4(%eax),%eax
 72d:	01 c2                	add    %eax,%edx
 72f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 732:	89 50 04             	mov    %edx,0x4(%eax)
 735:	8b 45 f8             	mov    -0x8(%ebp),%eax
 738:	8b 10                	mov    (%eax),%edx
 73a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73d:	89 10                	mov    %edx,(%eax)
 73f:	eb 08                	jmp    749 <free+0xd7>
 741:	8b 45 fc             	mov    -0x4(%ebp),%eax
 744:	8b 55 f8             	mov    -0x8(%ebp),%edx
 747:	89 10                	mov    %edx,(%eax)
 749:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74c:	a3 40 0b 00 00       	mov    %eax,0xb40
 751:	c9                   	leave  
 752:	c3                   	ret    

00000753 <morecore>:
 753:	55                   	push   %ebp
 754:	89 e5                	mov    %esp,%ebp
 756:	83 ec 28             	sub    $0x28,%esp
 759:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 760:	77 07                	ja     769 <morecore+0x16>
 762:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 769:	8b 45 08             	mov    0x8(%ebp),%eax
 76c:	c1 e0 03             	shl    $0x3,%eax
 76f:	89 04 24             	mov    %eax,(%esp)
 772:	e8 30 fc ff ff       	call   3a7 <sbrk>
 777:	89 45 f4             	mov    %eax,-0xc(%ebp)
 77a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 77e:	75 07                	jne    787 <morecore+0x34>
 780:	b8 00 00 00 00       	mov    $0x0,%eax
 785:	eb 22                	jmp    7a9 <morecore+0x56>
 787:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 78d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 790:	8b 55 08             	mov    0x8(%ebp),%edx
 793:	89 50 04             	mov    %edx,0x4(%eax)
 796:	8b 45 f0             	mov    -0x10(%ebp),%eax
 799:	83 c0 08             	add    $0x8,%eax
 79c:	89 04 24             	mov    %eax,(%esp)
 79f:	e8 ce fe ff ff       	call   672 <free>
 7a4:	a1 40 0b 00 00       	mov    0xb40,%eax
 7a9:	c9                   	leave  
 7aa:	c3                   	ret    

000007ab <malloc>:
 7ab:	55                   	push   %ebp
 7ac:	89 e5                	mov    %esp,%ebp
 7ae:	83 ec 28             	sub    $0x28,%esp
 7b1:	8b 45 08             	mov    0x8(%ebp),%eax
 7b4:	83 c0 07             	add    $0x7,%eax
 7b7:	c1 e8 03             	shr    $0x3,%eax
 7ba:	83 c0 01             	add    $0x1,%eax
 7bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
 7c0:	a1 40 0b 00 00       	mov    0xb40,%eax
 7c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7cc:	75 23                	jne    7f1 <malloc+0x46>
 7ce:	c7 45 f0 38 0b 00 00 	movl   $0xb38,-0x10(%ebp)
 7d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d8:	a3 40 0b 00 00       	mov    %eax,0xb40
 7dd:	a1 40 0b 00 00       	mov    0xb40,%eax
 7e2:	a3 38 0b 00 00       	mov    %eax,0xb38
 7e7:	c7 05 3c 0b 00 00 00 	movl   $0x0,0xb3c
 7ee:	00 00 00 
 7f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f4:	8b 00                	mov    (%eax),%eax
 7f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fc:	8b 40 04             	mov    0x4(%eax),%eax
 7ff:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 802:	72 4d                	jb     851 <malloc+0xa6>
 804:	8b 45 f4             	mov    -0xc(%ebp),%eax
 807:	8b 40 04             	mov    0x4(%eax),%eax
 80a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 80d:	75 0c                	jne    81b <malloc+0x70>
 80f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 812:	8b 10                	mov    (%eax),%edx
 814:	8b 45 f0             	mov    -0x10(%ebp),%eax
 817:	89 10                	mov    %edx,(%eax)
 819:	eb 26                	jmp    841 <malloc+0x96>
 81b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81e:	8b 40 04             	mov    0x4(%eax),%eax
 821:	2b 45 ec             	sub    -0x14(%ebp),%eax
 824:	89 c2                	mov    %eax,%edx
 826:	8b 45 f4             	mov    -0xc(%ebp),%eax
 829:	89 50 04             	mov    %edx,0x4(%eax)
 82c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82f:	8b 40 04             	mov    0x4(%eax),%eax
 832:	c1 e0 03             	shl    $0x3,%eax
 835:	01 45 f4             	add    %eax,-0xc(%ebp)
 838:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 83e:	89 50 04             	mov    %edx,0x4(%eax)
 841:	8b 45 f0             	mov    -0x10(%ebp),%eax
 844:	a3 40 0b 00 00       	mov    %eax,0xb40
 849:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84c:	83 c0 08             	add    $0x8,%eax
 84f:	eb 38                	jmp    889 <malloc+0xde>
 851:	a1 40 0b 00 00       	mov    0xb40,%eax
 856:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 859:	75 1b                	jne    876 <malloc+0xcb>
 85b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 85e:	89 04 24             	mov    %eax,(%esp)
 861:	e8 ed fe ff ff       	call   753 <morecore>
 866:	89 45 f4             	mov    %eax,-0xc(%ebp)
 869:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 86d:	75 07                	jne    876 <malloc+0xcb>
 86f:	b8 00 00 00 00       	mov    $0x0,%eax
 874:	eb 13                	jmp    889 <malloc+0xde>
 876:	8b 45 f4             	mov    -0xc(%ebp),%eax
 879:	89 45 f0             	mov    %eax,-0x10(%ebp)
 87c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87f:	8b 00                	mov    (%eax),%eax
 881:	89 45 f4             	mov    %eax,-0xc(%ebp)
 884:	e9 70 ff ff ff       	jmp    7f9 <malloc+0x4e>
 889:	c9                   	leave  
 88a:	c3                   	ret    
