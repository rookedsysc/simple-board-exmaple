package com.example.simpleboard.common;

import lombok.Getter;
import lombok.Setter;

public interface EntityBase {
  String status = "REGISTERED";
  void setStatus(String status);
}
