package com.tuempresa.gestionra.controller;

import com.tuempresa.gestionra.model.Criterio;
import com.tuempresa.gestionra.model.Ra;
import com.tuempresa.gestionra.service.CriterioService;
import com.tuempresa.gestionra.service.RaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/criterios")
@CrossOrigin(origins = "*")
public class CriterioController {

    @Autowired
    private CriterioService criterioService;

    @Autowired
    private RaService raService;

    @GetMapping
    public List<Criterio> getAllCriterios() {
        return criterioService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Criterio> getCriterioById(@PathVariable Integer id) {
        return criterioService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/ra/{raId}")
    public List<Criterio> getCriteriosByRa(@PathVariable Integer raId) {
        return criterioService.findByRaId(raId);
    }

    @PostMapping
    public ResponseEntity<Criterio> createCriterio(@RequestBody Map<String, Object> payload) {
        if (!payload.containsKey("raId")) {
            return ResponseEntity.badRequest().build();
        }

        Integer raId = (Integer) payload.get("raId");
        return raService.findById(raId)
                .map(ra -> {
                    Criterio criterio = new Criterio();
                    criterio.setCodigo((String) payload.get("codigo"));
                    criterio.setDescripcion((String) payload.get("descripcion"));
                    if (payload.containsKey("ponderacion")) {
                        Object ponderacionObj = payload.get("ponderacion");
                        if (ponderacionObj instanceof Integer) {
                            criterio.setPonderacion(BigDecimal.valueOf((Integer) ponderacionObj));
                        } else if (ponderacionObj instanceof Double) {
                            criterio.setPonderacion(BigDecimal.valueOf((Double) ponderacionObj));
                        } else {
                             criterio.setPonderacion(new BigDecimal(ponderacionObj.toString()));
                        }
                    }
                    criterio.setRa(ra);
                    return ResponseEntity.ok(criterioService.save(criterio));
                })
                .orElse(ResponseEntity.badRequest().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<Criterio> updateCriterio(@PathVariable Integer id, @RequestBody Map<String, Object> payload) {
        return criterioService.findById(id)
                .map(criterio -> {
                    if (payload.containsKey("codigo")) criterio.setCodigo((String) payload.get("codigo"));
                    if (payload.containsKey("descripcion")) criterio.setDescripcion((String) payload.get("descripcion"));
                    if (payload.containsKey("ponderacion")) {
                         Object ponderacionObj = payload.get("ponderacion");
                        if (ponderacionObj instanceof Integer) {
                            criterio.setPonderacion(BigDecimal.valueOf((Integer) ponderacionObj));
                        } else if (ponderacionObj instanceof Double) {
                            criterio.setPonderacion(BigDecimal.valueOf((Double) ponderacionObj));
                        } else {
                             criterio.setPonderacion(new BigDecimal(ponderacionObj.toString()));
                        }
                    }
                    if (payload.containsKey("raId")) {
                        Integer raId = (Integer) payload.get("raId");
                        Ra ra = raService.findById(raId).orElse(null);
                        if (ra != null) {
                            criterio.setRa(ra);
                        }
                    }
                    return ResponseEntity.ok(criterioService.save(criterio));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCriterio(@PathVariable Integer id) {
        if (criterioService.findById(id).isPresent()) {
            criterioService.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
