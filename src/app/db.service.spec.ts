import { TestBed, inject } from '@angular/core/testing';

import { DBService } from './db.service';

describe('DBService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [DBService]
    });
  });

  it('should be created', inject([DBService], (service: DBService) => {
    expect(service).toBeTruthy();
  }));
});
