<?php
declare(strict_types=1);
class TopLevel { private $value;
public function __construct($value) { $this->value = $value; }
public static function from($obj): TopLevel { return new TopLevel($obj); }
public function to() { return $this->value; } }
