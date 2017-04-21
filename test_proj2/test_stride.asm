
_test_stride:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#define LIFETIME        1000        // (ticks)
#define COUNT_PERIOD    1000000     // (iteration)

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 24             	sub    $0x24,%esp
  11:	89 c8                	mov    %ecx,%eax
  uint i;
  int cnt = 0;
  13:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int cpu_share;
  uint start_tick;
  uint curr_tick;

  if (argc < 2) {
  1a:	83 38 01             	cmpl   $0x1,(%eax)
  1d:	7f 17                	jg     36 <main+0x36>
    printf(1, "usage: sched_test_stride cpu_share(%)\n");
  1f:	83 ec 08             	sub    $0x8,%esp
  22:	68 a8 08 00 00       	push   $0x8a8
  27:	6a 01                	push   $0x1
  29:	e8 ae 04 00 00       	call   4dc <printf>
  2e:	83 c4 10             	add    $0x10,%esp
    exit();
  31:	e8 06 03 00 00       	call   33c <exit>
  }

  cpu_share = atoi(argv[1]);
  36:	8b 40 04             	mov    0x4(%eax),%eax
  39:	83 c0 04             	add    $0x4,%eax
  3c:	8b 00                	mov    (%eax),%eax
  3e:	83 ec 0c             	sub    $0xc,%esp
  41:	50                   	push   %eax
  42:	e8 63 02 00 00       	call   2aa <atoi>
  47:	83 c4 10             	add    $0x10,%esp
  4a:	89 45 ec             	mov    %eax,-0x14(%ebp)

  // Register this process to the Stride scheduler
  if (set_cpu_share(cpu_share) < 0) {
  4d:	83 ec 0c             	sub    $0xc,%esp
  50:	ff 75 ec             	pushl  -0x14(%ebp)
  53:	e8 9c 03 00 00       	call   3f4 <set_cpu_share>
  58:	83 c4 10             	add    $0x10,%esp
  5b:	85 c0                	test   %eax,%eax
  5d:	79 17                	jns    76 <main+0x76>
    printf(1, "cannot set cpu share\n");
  5f:	83 ec 08             	sub    $0x8,%esp
  62:	68 cf 08 00 00       	push   $0x8cf
  67:	6a 01                	push   $0x1
  69:	e8 6e 04 00 00       	call   4dc <printf>
  6e:	83 c4 10             	add    $0x10,%esp
    exit();
  71:	e8 c6 02 00 00       	call   33c <exit>
  }

  // Get start time
  start_tick = uptime();
  76:	e8 59 03 00 00       	call   3d4 <uptime>
  7b:	89 45 e8             	mov    %eax,-0x18(%ebp)

  i = 0;
  7e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while (1) {
    i++;
  85:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

    // Prevent code optimization
    __sync_synchronize();
  89:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

    if (i == COUNT_PERIOD) {
  8e:	81 7d f4 40 42 0f 00 	cmpl   $0xf4240,-0xc(%ebp)
  95:	75 ee                	jne    85 <main+0x85>
      cnt++;
  97:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)

      // Get current time
      curr_tick = uptime();
  9b:	e8 34 03 00 00       	call   3d4 <uptime>
  a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)

      if (curr_tick - start_tick > LIFETIME) {
  a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  a6:	2b 45 e8             	sub    -0x18(%ebp),%eax
  a9:	3d e8 03 00 00       	cmp    $0x3e8,%eax
  ae:	76 1b                	jbe    cb <main+0xcb>
        // Terminate process
        printf(1, "STRIDE(%d%%), cnt: %d\n", cpu_share, cnt);
  b0:	ff 75 f0             	pushl  -0x10(%ebp)
  b3:	ff 75 ec             	pushl  -0x14(%ebp)
  b6:	68 e5 08 00 00       	push   $0x8e5
  bb:	6a 01                	push   $0x1
  bd:	e8 1a 04 00 00       	call   4dc <printf>
  c2:	83 c4 10             	add    $0x10,%esp
        break;
  c5:	90                   	nop
      }
      i = 0;
    }
  }

  exit();
  c6:	e8 71 02 00 00       	call   33c <exit>
      if (curr_tick - start_tick > LIFETIME) {
        // Terminate process
        printf(1, "STRIDE(%d%%), cnt: %d\n", cpu_share, cnt);
        break;
      }
      i = 0;
  cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    }
  }
  d2:	eb b1                	jmp    85 <main+0x85>

000000d4 <stosb>:
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	57                   	push   %edi
  d8:	53                   	push   %ebx
  d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  dc:	8b 55 10             	mov    0x10(%ebp),%edx
  df:	8b 45 0c             	mov    0xc(%ebp),%eax
  e2:	89 cb                	mov    %ecx,%ebx
  e4:	89 df                	mov    %ebx,%edi
  e6:	89 d1                	mov    %edx,%ecx
  e8:	fc                   	cld    
  e9:	f3 aa                	rep stos %al,%es:(%edi)
  eb:	89 ca                	mov    %ecx,%edx
  ed:	89 fb                	mov    %edi,%ebx
  ef:	89 5d 08             	mov    %ebx,0x8(%ebp)
  f2:	89 55 10             	mov    %edx,0x10(%ebp)
  f5:	5b                   	pop    %ebx
  f6:	5f                   	pop    %edi
  f7:	5d                   	pop    %ebp
  f8:	c3                   	ret    

000000f9 <strcpy>:
  f9:	55                   	push   %ebp
  fa:	89 e5                	mov    %esp,%ebp
  fc:	83 ec 10             	sub    $0x10,%esp
  ff:	8b 45 08             	mov    0x8(%ebp),%eax
 102:	89 45 fc             	mov    %eax,-0x4(%ebp)
 105:	90                   	nop
 106:	8b 45 08             	mov    0x8(%ebp),%eax
 109:	8d 50 01             	lea    0x1(%eax),%edx
 10c:	89 55 08             	mov    %edx,0x8(%ebp)
 10f:	8b 55 0c             	mov    0xc(%ebp),%edx
 112:	8d 4a 01             	lea    0x1(%edx),%ecx
 115:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 118:	0f b6 12             	movzbl (%edx),%edx
 11b:	88 10                	mov    %dl,(%eax)
 11d:	0f b6 00             	movzbl (%eax),%eax
 120:	84 c0                	test   %al,%al
 122:	75 e2                	jne    106 <strcpy+0xd>
 124:	8b 45 fc             	mov    -0x4(%ebp),%eax
 127:	c9                   	leave  
 128:	c3                   	ret    

00000129 <strcmp>:
 129:	55                   	push   %ebp
 12a:	89 e5                	mov    %esp,%ebp
 12c:	eb 08                	jmp    136 <strcmp+0xd>
 12e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 132:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 136:	8b 45 08             	mov    0x8(%ebp),%eax
 139:	0f b6 00             	movzbl (%eax),%eax
 13c:	84 c0                	test   %al,%al
 13e:	74 10                	je     150 <strcmp+0x27>
 140:	8b 45 08             	mov    0x8(%ebp),%eax
 143:	0f b6 10             	movzbl (%eax),%edx
 146:	8b 45 0c             	mov    0xc(%ebp),%eax
 149:	0f b6 00             	movzbl (%eax),%eax
 14c:	38 c2                	cmp    %al,%dl
 14e:	74 de                	je     12e <strcmp+0x5>
 150:	8b 45 08             	mov    0x8(%ebp),%eax
 153:	0f b6 00             	movzbl (%eax),%eax
 156:	0f b6 d0             	movzbl %al,%edx
 159:	8b 45 0c             	mov    0xc(%ebp),%eax
 15c:	0f b6 00             	movzbl (%eax),%eax
 15f:	0f b6 c0             	movzbl %al,%eax
 162:	29 c2                	sub    %eax,%edx
 164:	89 d0                	mov    %edx,%eax
 166:	5d                   	pop    %ebp
 167:	c3                   	ret    

00000168 <strlen>:
 168:	55                   	push   %ebp
 169:	89 e5                	mov    %esp,%ebp
 16b:	83 ec 10             	sub    $0x10,%esp
 16e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 175:	eb 04                	jmp    17b <strlen+0x13>
 177:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 17b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	01 d0                	add    %edx,%eax
 183:	0f b6 00             	movzbl (%eax),%eax
 186:	84 c0                	test   %al,%al
 188:	75 ed                	jne    177 <strlen+0xf>
 18a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 18d:	c9                   	leave  
 18e:	c3                   	ret    

0000018f <memset>:
 18f:	55                   	push   %ebp
 190:	89 e5                	mov    %esp,%ebp
 192:	83 ec 0c             	sub    $0xc,%esp
 195:	8b 45 10             	mov    0x10(%ebp),%eax
 198:	89 44 24 08          	mov    %eax,0x8(%esp)
 19c:	8b 45 0c             	mov    0xc(%ebp),%eax
 19f:	89 44 24 04          	mov    %eax,0x4(%esp)
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	89 04 24             	mov    %eax,(%esp)
 1a9:	e8 26 ff ff ff       	call   d4 <stosb>
 1ae:	8b 45 08             	mov    0x8(%ebp),%eax
 1b1:	c9                   	leave  
 1b2:	c3                   	ret    

000001b3 <strchr>:
 1b3:	55                   	push   %ebp
 1b4:	89 e5                	mov    %esp,%ebp
 1b6:	83 ec 04             	sub    $0x4,%esp
 1b9:	8b 45 0c             	mov    0xc(%ebp),%eax
 1bc:	88 45 fc             	mov    %al,-0x4(%ebp)
 1bf:	eb 14                	jmp    1d5 <strchr+0x22>
 1c1:	8b 45 08             	mov    0x8(%ebp),%eax
 1c4:	0f b6 00             	movzbl (%eax),%eax
 1c7:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1ca:	75 05                	jne    1d1 <strchr+0x1e>
 1cc:	8b 45 08             	mov    0x8(%ebp),%eax
 1cf:	eb 13                	jmp    1e4 <strchr+0x31>
 1d1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1d5:	8b 45 08             	mov    0x8(%ebp),%eax
 1d8:	0f b6 00             	movzbl (%eax),%eax
 1db:	84 c0                	test   %al,%al
 1dd:	75 e2                	jne    1c1 <strchr+0xe>
 1df:	b8 00 00 00 00       	mov    $0x0,%eax
 1e4:	c9                   	leave  
 1e5:	c3                   	ret    

000001e6 <gets>:
 1e6:	55                   	push   %ebp
 1e7:	89 e5                	mov    %esp,%ebp
 1e9:	83 ec 28             	sub    $0x28,%esp
 1ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1f3:	eb 4c                	jmp    241 <gets+0x5b>
 1f5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1fc:	00 
 1fd:	8d 45 ef             	lea    -0x11(%ebp),%eax
 200:	89 44 24 04          	mov    %eax,0x4(%esp)
 204:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 20b:	e8 44 01 00 00       	call   354 <read>
 210:	89 45 f0             	mov    %eax,-0x10(%ebp)
 213:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 217:	7f 02                	jg     21b <gets+0x35>
 219:	eb 31                	jmp    24c <gets+0x66>
 21b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 21e:	8d 50 01             	lea    0x1(%eax),%edx
 221:	89 55 f4             	mov    %edx,-0xc(%ebp)
 224:	89 c2                	mov    %eax,%edx
 226:	8b 45 08             	mov    0x8(%ebp),%eax
 229:	01 c2                	add    %eax,%edx
 22b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 22f:	88 02                	mov    %al,(%edx)
 231:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 235:	3c 0a                	cmp    $0xa,%al
 237:	74 13                	je     24c <gets+0x66>
 239:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 23d:	3c 0d                	cmp    $0xd,%al
 23f:	74 0b                	je     24c <gets+0x66>
 241:	8b 45 f4             	mov    -0xc(%ebp),%eax
 244:	83 c0 01             	add    $0x1,%eax
 247:	3b 45 0c             	cmp    0xc(%ebp),%eax
 24a:	7c a9                	jl     1f5 <gets+0xf>
 24c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 24f:	8b 45 08             	mov    0x8(%ebp),%eax
 252:	01 d0                	add    %edx,%eax
 254:	c6 00 00             	movb   $0x0,(%eax)
 257:	8b 45 08             	mov    0x8(%ebp),%eax
 25a:	c9                   	leave  
 25b:	c3                   	ret    

0000025c <stat>:
 25c:	55                   	push   %ebp
 25d:	89 e5                	mov    %esp,%ebp
 25f:	83 ec 28             	sub    $0x28,%esp
 262:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 269:	00 
 26a:	8b 45 08             	mov    0x8(%ebp),%eax
 26d:	89 04 24             	mov    %eax,(%esp)
 270:	e8 07 01 00 00       	call   37c <open>
 275:	89 45 f4             	mov    %eax,-0xc(%ebp)
 278:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 27c:	79 07                	jns    285 <stat+0x29>
 27e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 283:	eb 23                	jmp    2a8 <stat+0x4c>
 285:	8b 45 0c             	mov    0xc(%ebp),%eax
 288:	89 44 24 04          	mov    %eax,0x4(%esp)
 28c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 28f:	89 04 24             	mov    %eax,(%esp)
 292:	e8 fd 00 00 00       	call   394 <fstat>
 297:	89 45 f0             	mov    %eax,-0x10(%ebp)
 29a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 29d:	89 04 24             	mov    %eax,(%esp)
 2a0:	e8 bf 00 00 00       	call   364 <close>
 2a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2a8:	c9                   	leave  
 2a9:	c3                   	ret    

000002aa <atoi>:
 2aa:	55                   	push   %ebp
 2ab:	89 e5                	mov    %esp,%ebp
 2ad:	83 ec 10             	sub    $0x10,%esp
 2b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 2b7:	eb 25                	jmp    2de <atoi+0x34>
 2b9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2bc:	89 d0                	mov    %edx,%eax
 2be:	c1 e0 02             	shl    $0x2,%eax
 2c1:	01 d0                	add    %edx,%eax
 2c3:	01 c0                	add    %eax,%eax
 2c5:	89 c1                	mov    %eax,%ecx
 2c7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ca:	8d 50 01             	lea    0x1(%eax),%edx
 2cd:	89 55 08             	mov    %edx,0x8(%ebp)
 2d0:	0f b6 00             	movzbl (%eax),%eax
 2d3:	0f be c0             	movsbl %al,%eax
 2d6:	01 c8                	add    %ecx,%eax
 2d8:	83 e8 30             	sub    $0x30,%eax
 2db:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2de:	8b 45 08             	mov    0x8(%ebp),%eax
 2e1:	0f b6 00             	movzbl (%eax),%eax
 2e4:	3c 2f                	cmp    $0x2f,%al
 2e6:	7e 0a                	jle    2f2 <atoi+0x48>
 2e8:	8b 45 08             	mov    0x8(%ebp),%eax
 2eb:	0f b6 00             	movzbl (%eax),%eax
 2ee:	3c 39                	cmp    $0x39,%al
 2f0:	7e c7                	jle    2b9 <atoi+0xf>
 2f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2f5:	c9                   	leave  
 2f6:	c3                   	ret    

000002f7 <memmove>:
 2f7:	55                   	push   %ebp
 2f8:	89 e5                	mov    %esp,%ebp
 2fa:	83 ec 10             	sub    $0x10,%esp
 2fd:	8b 45 08             	mov    0x8(%ebp),%eax
 300:	89 45 fc             	mov    %eax,-0x4(%ebp)
 303:	8b 45 0c             	mov    0xc(%ebp),%eax
 306:	89 45 f8             	mov    %eax,-0x8(%ebp)
 309:	eb 17                	jmp    322 <memmove+0x2b>
 30b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 30e:	8d 50 01             	lea    0x1(%eax),%edx
 311:	89 55 fc             	mov    %edx,-0x4(%ebp)
 314:	8b 55 f8             	mov    -0x8(%ebp),%edx
 317:	8d 4a 01             	lea    0x1(%edx),%ecx
 31a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 31d:	0f b6 12             	movzbl (%edx),%edx
 320:	88 10                	mov    %dl,(%eax)
 322:	8b 45 10             	mov    0x10(%ebp),%eax
 325:	8d 50 ff             	lea    -0x1(%eax),%edx
 328:	89 55 10             	mov    %edx,0x10(%ebp)
 32b:	85 c0                	test   %eax,%eax
 32d:	7f dc                	jg     30b <memmove+0x14>
 32f:	8b 45 08             	mov    0x8(%ebp),%eax
 332:	c9                   	leave  
 333:	c3                   	ret    

00000334 <fork>:
 334:	b8 01 00 00 00       	mov    $0x1,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <exit>:
 33c:	b8 02 00 00 00       	mov    $0x2,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <wait>:
 344:	b8 03 00 00 00       	mov    $0x3,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <pipe>:
 34c:	b8 04 00 00 00       	mov    $0x4,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <read>:
 354:	b8 05 00 00 00       	mov    $0x5,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <write>:
 35c:	b8 10 00 00 00       	mov    $0x10,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <close>:
 364:	b8 15 00 00 00       	mov    $0x15,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <kill>:
 36c:	b8 06 00 00 00       	mov    $0x6,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <exec>:
 374:	b8 07 00 00 00       	mov    $0x7,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <open>:
 37c:	b8 0f 00 00 00       	mov    $0xf,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <mknod>:
 384:	b8 11 00 00 00       	mov    $0x11,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <unlink>:
 38c:	b8 12 00 00 00       	mov    $0x12,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <fstat>:
 394:	b8 08 00 00 00       	mov    $0x8,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <link>:
 39c:	b8 13 00 00 00       	mov    $0x13,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <mkdir>:
 3a4:	b8 14 00 00 00       	mov    $0x14,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <chdir>:
 3ac:	b8 09 00 00 00       	mov    $0x9,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <dup>:
 3b4:	b8 0a 00 00 00       	mov    $0xa,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <getpid>:
 3bc:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <sbrk>:
 3c4:	b8 0c 00 00 00       	mov    $0xc,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <sleep>:
 3cc:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <uptime>:
 3d4:	b8 0e 00 00 00       	mov    $0xe,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <my_syscall>:
 3dc:	b8 16 00 00 00       	mov    $0x16,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret    

000003e4 <yield>:
 3e4:	b8 17 00 00 00       	mov    $0x17,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret    

000003ec <getlev>:
 3ec:	b8 18 00 00 00       	mov    $0x18,%eax
 3f1:	cd 40                	int    $0x40
 3f3:	c3                   	ret    

000003f4 <set_cpu_share>:
 3f4:	b8 19 00 00 00       	mov    $0x19,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <putc>:
 3fc:	55                   	push   %ebp
 3fd:	89 e5                	mov    %esp,%ebp
 3ff:	83 ec 18             	sub    $0x18,%esp
 402:	8b 45 0c             	mov    0xc(%ebp),%eax
 405:	88 45 f4             	mov    %al,-0xc(%ebp)
 408:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 40f:	00 
 410:	8d 45 f4             	lea    -0xc(%ebp),%eax
 413:	89 44 24 04          	mov    %eax,0x4(%esp)
 417:	8b 45 08             	mov    0x8(%ebp),%eax
 41a:	89 04 24             	mov    %eax,(%esp)
 41d:	e8 3a ff ff ff       	call   35c <write>
 422:	c9                   	leave  
 423:	c3                   	ret    

00000424 <printint>:
 424:	55                   	push   %ebp
 425:	89 e5                	mov    %esp,%ebp
 427:	56                   	push   %esi
 428:	53                   	push   %ebx
 429:	83 ec 30             	sub    $0x30,%esp
 42c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 433:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 437:	74 17                	je     450 <printint+0x2c>
 439:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 43d:	79 11                	jns    450 <printint+0x2c>
 43f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 446:	8b 45 0c             	mov    0xc(%ebp),%eax
 449:	f7 d8                	neg    %eax
 44b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 44e:	eb 06                	jmp    456 <printint+0x32>
 450:	8b 45 0c             	mov    0xc(%ebp),%eax
 453:	89 45 ec             	mov    %eax,-0x14(%ebp)
 456:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 45d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 460:	8d 41 01             	lea    0x1(%ecx),%eax
 463:	89 45 f4             	mov    %eax,-0xc(%ebp)
 466:	8b 5d 10             	mov    0x10(%ebp),%ebx
 469:	8b 45 ec             	mov    -0x14(%ebp),%eax
 46c:	ba 00 00 00 00       	mov    $0x0,%edx
 471:	f7 f3                	div    %ebx
 473:	89 d0                	mov    %edx,%eax
 475:	0f b6 80 50 0b 00 00 	movzbl 0xb50(%eax),%eax
 47c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 480:	8b 75 10             	mov    0x10(%ebp),%esi
 483:	8b 45 ec             	mov    -0x14(%ebp),%eax
 486:	ba 00 00 00 00       	mov    $0x0,%edx
 48b:	f7 f6                	div    %esi
 48d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 490:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 494:	75 c7                	jne    45d <printint+0x39>
 496:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 49a:	74 10                	je     4ac <printint+0x88>
 49c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49f:	8d 50 01             	lea    0x1(%eax),%edx
 4a2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4a5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 4aa:	eb 1f                	jmp    4cb <printint+0xa7>
 4ac:	eb 1d                	jmp    4cb <printint+0xa7>
 4ae:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4b4:	01 d0                	add    %edx,%eax
 4b6:	0f b6 00             	movzbl (%eax),%eax
 4b9:	0f be c0             	movsbl %al,%eax
 4bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c0:	8b 45 08             	mov    0x8(%ebp),%eax
 4c3:	89 04 24             	mov    %eax,(%esp)
 4c6:	e8 31 ff ff ff       	call   3fc <putc>
 4cb:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4cf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4d3:	79 d9                	jns    4ae <printint+0x8a>
 4d5:	83 c4 30             	add    $0x30,%esp
 4d8:	5b                   	pop    %ebx
 4d9:	5e                   	pop    %esi
 4da:	5d                   	pop    %ebp
 4db:	c3                   	ret    

000004dc <printf>:
 4dc:	55                   	push   %ebp
 4dd:	89 e5                	mov    %esp,%ebp
 4df:	83 ec 38             	sub    $0x38,%esp
 4e2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 4e9:	8d 45 0c             	lea    0xc(%ebp),%eax
 4ec:	83 c0 04             	add    $0x4,%eax
 4ef:	89 45 e8             	mov    %eax,-0x18(%ebp)
 4f2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4f9:	e9 7c 01 00 00       	jmp    67a <printf+0x19e>
 4fe:	8b 55 0c             	mov    0xc(%ebp),%edx
 501:	8b 45 f0             	mov    -0x10(%ebp),%eax
 504:	01 d0                	add    %edx,%eax
 506:	0f b6 00             	movzbl (%eax),%eax
 509:	0f be c0             	movsbl %al,%eax
 50c:	25 ff 00 00 00       	and    $0xff,%eax
 511:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 514:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 518:	75 2c                	jne    546 <printf+0x6a>
 51a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 51e:	75 0c                	jne    52c <printf+0x50>
 520:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 527:	e9 4a 01 00 00       	jmp    676 <printf+0x19a>
 52c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 52f:	0f be c0             	movsbl %al,%eax
 532:	89 44 24 04          	mov    %eax,0x4(%esp)
 536:	8b 45 08             	mov    0x8(%ebp),%eax
 539:	89 04 24             	mov    %eax,(%esp)
 53c:	e8 bb fe ff ff       	call   3fc <putc>
 541:	e9 30 01 00 00       	jmp    676 <printf+0x19a>
 546:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 54a:	0f 85 26 01 00 00    	jne    676 <printf+0x19a>
 550:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 554:	75 2d                	jne    583 <printf+0xa7>
 556:	8b 45 e8             	mov    -0x18(%ebp),%eax
 559:	8b 00                	mov    (%eax),%eax
 55b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 562:	00 
 563:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 56a:	00 
 56b:	89 44 24 04          	mov    %eax,0x4(%esp)
 56f:	8b 45 08             	mov    0x8(%ebp),%eax
 572:	89 04 24             	mov    %eax,(%esp)
 575:	e8 aa fe ff ff       	call   424 <printint>
 57a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 57e:	e9 ec 00 00 00       	jmp    66f <printf+0x193>
 583:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 587:	74 06                	je     58f <printf+0xb3>
 589:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 58d:	75 2d                	jne    5bc <printf+0xe0>
 58f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 592:	8b 00                	mov    (%eax),%eax
 594:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 59b:	00 
 59c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5a3:	00 
 5a4:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a8:	8b 45 08             	mov    0x8(%ebp),%eax
 5ab:	89 04 24             	mov    %eax,(%esp)
 5ae:	e8 71 fe ff ff       	call   424 <printint>
 5b3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b7:	e9 b3 00 00 00       	jmp    66f <printf+0x193>
 5bc:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5c0:	75 45                	jne    607 <printf+0x12b>
 5c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c5:	8b 00                	mov    (%eax),%eax
 5c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
 5ca:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5d2:	75 09                	jne    5dd <printf+0x101>
 5d4:	c7 45 f4 fc 08 00 00 	movl   $0x8fc,-0xc(%ebp)
 5db:	eb 1e                	jmp    5fb <printf+0x11f>
 5dd:	eb 1c                	jmp    5fb <printf+0x11f>
 5df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e2:	0f b6 00             	movzbl (%eax),%eax
 5e5:	0f be c0             	movsbl %al,%eax
 5e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ec:	8b 45 08             	mov    0x8(%ebp),%eax
 5ef:	89 04 24             	mov    %eax,(%esp)
 5f2:	e8 05 fe ff ff       	call   3fc <putc>
 5f7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5fe:	0f b6 00             	movzbl (%eax),%eax
 601:	84 c0                	test   %al,%al
 603:	75 da                	jne    5df <printf+0x103>
 605:	eb 68                	jmp    66f <printf+0x193>
 607:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 60b:	75 1d                	jne    62a <printf+0x14e>
 60d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 610:	8b 00                	mov    (%eax),%eax
 612:	0f be c0             	movsbl %al,%eax
 615:	89 44 24 04          	mov    %eax,0x4(%esp)
 619:	8b 45 08             	mov    0x8(%ebp),%eax
 61c:	89 04 24             	mov    %eax,(%esp)
 61f:	e8 d8 fd ff ff       	call   3fc <putc>
 624:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 628:	eb 45                	jmp    66f <printf+0x193>
 62a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 62e:	75 17                	jne    647 <printf+0x16b>
 630:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 633:	0f be c0             	movsbl %al,%eax
 636:	89 44 24 04          	mov    %eax,0x4(%esp)
 63a:	8b 45 08             	mov    0x8(%ebp),%eax
 63d:	89 04 24             	mov    %eax,(%esp)
 640:	e8 b7 fd ff ff       	call   3fc <putc>
 645:	eb 28                	jmp    66f <printf+0x193>
 647:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 64e:	00 
 64f:	8b 45 08             	mov    0x8(%ebp),%eax
 652:	89 04 24             	mov    %eax,(%esp)
 655:	e8 a2 fd ff ff       	call   3fc <putc>
 65a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 65d:	0f be c0             	movsbl %al,%eax
 660:	89 44 24 04          	mov    %eax,0x4(%esp)
 664:	8b 45 08             	mov    0x8(%ebp),%eax
 667:	89 04 24             	mov    %eax,(%esp)
 66a:	e8 8d fd ff ff       	call   3fc <putc>
 66f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 676:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 67a:	8b 55 0c             	mov    0xc(%ebp),%edx
 67d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 680:	01 d0                	add    %edx,%eax
 682:	0f b6 00             	movzbl (%eax),%eax
 685:	84 c0                	test   %al,%al
 687:	0f 85 71 fe ff ff    	jne    4fe <printf+0x22>
 68d:	c9                   	leave  
 68e:	c3                   	ret    

0000068f <free>:
 68f:	55                   	push   %ebp
 690:	89 e5                	mov    %esp,%ebp
 692:	83 ec 10             	sub    $0x10,%esp
 695:	8b 45 08             	mov    0x8(%ebp),%eax
 698:	83 e8 08             	sub    $0x8,%eax
 69b:	89 45 f8             	mov    %eax,-0x8(%ebp)
 69e:	a1 6c 0b 00 00       	mov    0xb6c,%eax
 6a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6a6:	eb 24                	jmp    6cc <free+0x3d>
 6a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ab:	8b 00                	mov    (%eax),%eax
 6ad:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6b0:	77 12                	ja     6c4 <free+0x35>
 6b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6b8:	77 24                	ja     6de <free+0x4f>
 6ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bd:	8b 00                	mov    (%eax),%eax
 6bf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6c2:	77 1a                	ja     6de <free+0x4f>
 6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c7:	8b 00                	mov    (%eax),%eax
 6c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6d2:	76 d4                	jbe    6a8 <free+0x19>
 6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d7:	8b 00                	mov    (%eax),%eax
 6d9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6dc:	76 ca                	jbe    6a8 <free+0x19>
 6de:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e1:	8b 40 04             	mov    0x4(%eax),%eax
 6e4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ee:	01 c2                	add    %eax,%edx
 6f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f3:	8b 00                	mov    (%eax),%eax
 6f5:	39 c2                	cmp    %eax,%edx
 6f7:	75 24                	jne    71d <free+0x8e>
 6f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fc:	8b 50 04             	mov    0x4(%eax),%edx
 6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 702:	8b 00                	mov    (%eax),%eax
 704:	8b 40 04             	mov    0x4(%eax),%eax
 707:	01 c2                	add    %eax,%edx
 709:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70c:	89 50 04             	mov    %edx,0x4(%eax)
 70f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 712:	8b 00                	mov    (%eax),%eax
 714:	8b 10                	mov    (%eax),%edx
 716:	8b 45 f8             	mov    -0x8(%ebp),%eax
 719:	89 10                	mov    %edx,(%eax)
 71b:	eb 0a                	jmp    727 <free+0x98>
 71d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 720:	8b 10                	mov    (%eax),%edx
 722:	8b 45 f8             	mov    -0x8(%ebp),%eax
 725:	89 10                	mov    %edx,(%eax)
 727:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72a:	8b 40 04             	mov    0x4(%eax),%eax
 72d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 734:	8b 45 fc             	mov    -0x4(%ebp),%eax
 737:	01 d0                	add    %edx,%eax
 739:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 73c:	75 20                	jne    75e <free+0xcf>
 73e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 741:	8b 50 04             	mov    0x4(%eax),%edx
 744:	8b 45 f8             	mov    -0x8(%ebp),%eax
 747:	8b 40 04             	mov    0x4(%eax),%eax
 74a:	01 c2                	add    %eax,%edx
 74c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74f:	89 50 04             	mov    %edx,0x4(%eax)
 752:	8b 45 f8             	mov    -0x8(%ebp),%eax
 755:	8b 10                	mov    (%eax),%edx
 757:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75a:	89 10                	mov    %edx,(%eax)
 75c:	eb 08                	jmp    766 <free+0xd7>
 75e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 761:	8b 55 f8             	mov    -0x8(%ebp),%edx
 764:	89 10                	mov    %edx,(%eax)
 766:	8b 45 fc             	mov    -0x4(%ebp),%eax
 769:	a3 6c 0b 00 00       	mov    %eax,0xb6c
 76e:	c9                   	leave  
 76f:	c3                   	ret    

00000770 <morecore>:
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	83 ec 28             	sub    $0x28,%esp
 776:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 77d:	77 07                	ja     786 <morecore+0x16>
 77f:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 786:	8b 45 08             	mov    0x8(%ebp),%eax
 789:	c1 e0 03             	shl    $0x3,%eax
 78c:	89 04 24             	mov    %eax,(%esp)
 78f:	e8 30 fc ff ff       	call   3c4 <sbrk>
 794:	89 45 f4             	mov    %eax,-0xc(%ebp)
 797:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 79b:	75 07                	jne    7a4 <morecore+0x34>
 79d:	b8 00 00 00 00       	mov    $0x0,%eax
 7a2:	eb 22                	jmp    7c6 <morecore+0x56>
 7a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ad:	8b 55 08             	mov    0x8(%ebp),%edx
 7b0:	89 50 04             	mov    %edx,0x4(%eax)
 7b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b6:	83 c0 08             	add    $0x8,%eax
 7b9:	89 04 24             	mov    %eax,(%esp)
 7bc:	e8 ce fe ff ff       	call   68f <free>
 7c1:	a1 6c 0b 00 00       	mov    0xb6c,%eax
 7c6:	c9                   	leave  
 7c7:	c3                   	ret    

000007c8 <malloc>:
 7c8:	55                   	push   %ebp
 7c9:	89 e5                	mov    %esp,%ebp
 7cb:	83 ec 28             	sub    $0x28,%esp
 7ce:	8b 45 08             	mov    0x8(%ebp),%eax
 7d1:	83 c0 07             	add    $0x7,%eax
 7d4:	c1 e8 03             	shr    $0x3,%eax
 7d7:	83 c0 01             	add    $0x1,%eax
 7da:	89 45 ec             	mov    %eax,-0x14(%ebp)
 7dd:	a1 6c 0b 00 00       	mov    0xb6c,%eax
 7e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7e9:	75 23                	jne    80e <malloc+0x46>
 7eb:	c7 45 f0 64 0b 00 00 	movl   $0xb64,-0x10(%ebp)
 7f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f5:	a3 6c 0b 00 00       	mov    %eax,0xb6c
 7fa:	a1 6c 0b 00 00       	mov    0xb6c,%eax
 7ff:	a3 64 0b 00 00       	mov    %eax,0xb64
 804:	c7 05 68 0b 00 00 00 	movl   $0x0,0xb68
 80b:	00 00 00 
 80e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 811:	8b 00                	mov    (%eax),%eax
 813:	89 45 f4             	mov    %eax,-0xc(%ebp)
 816:	8b 45 f4             	mov    -0xc(%ebp),%eax
 819:	8b 40 04             	mov    0x4(%eax),%eax
 81c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 81f:	72 4d                	jb     86e <malloc+0xa6>
 821:	8b 45 f4             	mov    -0xc(%ebp),%eax
 824:	8b 40 04             	mov    0x4(%eax),%eax
 827:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 82a:	75 0c                	jne    838 <malloc+0x70>
 82c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82f:	8b 10                	mov    (%eax),%edx
 831:	8b 45 f0             	mov    -0x10(%ebp),%eax
 834:	89 10                	mov    %edx,(%eax)
 836:	eb 26                	jmp    85e <malloc+0x96>
 838:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83b:	8b 40 04             	mov    0x4(%eax),%eax
 83e:	2b 45 ec             	sub    -0x14(%ebp),%eax
 841:	89 c2                	mov    %eax,%edx
 843:	8b 45 f4             	mov    -0xc(%ebp),%eax
 846:	89 50 04             	mov    %edx,0x4(%eax)
 849:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84c:	8b 40 04             	mov    0x4(%eax),%eax
 84f:	c1 e0 03             	shl    $0x3,%eax
 852:	01 45 f4             	add    %eax,-0xc(%ebp)
 855:	8b 45 f4             	mov    -0xc(%ebp),%eax
 858:	8b 55 ec             	mov    -0x14(%ebp),%edx
 85b:	89 50 04             	mov    %edx,0x4(%eax)
 85e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 861:	a3 6c 0b 00 00       	mov    %eax,0xb6c
 866:	8b 45 f4             	mov    -0xc(%ebp),%eax
 869:	83 c0 08             	add    $0x8,%eax
 86c:	eb 38                	jmp    8a6 <malloc+0xde>
 86e:	a1 6c 0b 00 00       	mov    0xb6c,%eax
 873:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 876:	75 1b                	jne    893 <malloc+0xcb>
 878:	8b 45 ec             	mov    -0x14(%ebp),%eax
 87b:	89 04 24             	mov    %eax,(%esp)
 87e:	e8 ed fe ff ff       	call   770 <morecore>
 883:	89 45 f4             	mov    %eax,-0xc(%ebp)
 886:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 88a:	75 07                	jne    893 <malloc+0xcb>
 88c:	b8 00 00 00 00       	mov    $0x0,%eax
 891:	eb 13                	jmp    8a6 <malloc+0xde>
 893:	8b 45 f4             	mov    -0xc(%ebp),%eax
 896:	89 45 f0             	mov    %eax,-0x10(%ebp)
 899:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89c:	8b 00                	mov    (%eax),%eax
 89e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8a1:	e9 70 ff ff ff       	jmp    816 <malloc+0x4e>
 8a6:	c9                   	leave  
 8a7:	c3                   	ret    
