// Registro.java
@Entity
@Data
public class Registro {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String tipo;
    private BigDecimal cantidad;

    @ManyToOne
    private Usuario creadoPor;
}