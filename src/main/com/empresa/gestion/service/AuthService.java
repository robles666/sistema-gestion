@Service
@RequiredArgsConstructor
public class AuthService {
    private final UsuarioRepository usuarioRepository;
    private final JwtUtil jwtUtil;
    private final IpValidationService ipService;
    private final LoginAttemptService attemptService;
    private final PasswordEncoder passwordEncoder;

    public ResponseEntity<?> authenticate(LoginRequest request, String ip) {
        // 1. Verificar IP
        if (!ipService.ipAutorizada(ip)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN)
                    .body("Acceso no autorizado desde esta IP");
        }

        // 2. Verificar intentos fallidos
        if (attemptService.isBlocked(request.getUsername())) {
            return ResponseEntity.status(HttpStatus.TOO_MANY_REQUESTS)
                    .body("Cuenta temporalmente bloqueada");
        }

        // 3. Autenticación tradicional
        Usuario usuario = usuarioRepository.findByUsername(request.getUsername())
                .orElseThrow(() -> new UsernameNotFoundException("Usuario no encontrado"));

        if (!passwordEncoder.matches(request.getPassword(), usuario.getPassword())) {
            attemptService.loginFailed(request.getUsername());
            throw new BadCredentialsException("Credenciales inválidas");
        }

        attemptService.loginSuccess(request.getUsername());

        // 4. Generar token
        String token = jwtUtil.generateToken(usuario.getUsername());

        return ResponseEntity.ok(Map.of(
                "token", token,
                "username", usuario.getUsername(),
                "roles", usuario.getRoles()
        ));
    }
}