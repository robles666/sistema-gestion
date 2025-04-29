package com.empresa.gestion.model;

import jakarta.persistence.*;
import lombok.Data;
import java.util.Date;

@Entity
@Data  // Lombok: genera getters/setters automáticamente
@Table(name = "registros")
public class Registro {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String tipo;
    private Integer cantidad;

    @Temporal(TemporalType.DATE)
    private Date fecha;
}